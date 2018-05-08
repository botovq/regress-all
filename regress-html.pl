#!/usr/bin/perl
# convert all test results to a html table

# Copyright (c) 2016-2017 Alexander Bluhm <bluhm@genua.de>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use strict;
use warnings;
use Cwd;
use File::Basename;
use HTML::Entities;
use Getopt::Std;
use POSIX;
use URI::Escape;

my $now = strftime("%FT%TZ", gmtime);

my %opts;
getopts('h:l', \%opts) or do {
    print STDERR <<"EOF";
usage: $0 [-l] [-h host]
    -h host     optional user and host for version information
    -l		create latest.html with one column of the latest results
EOF
    exit(2);
};

my $dir = dirname($0). "/..";
chdir($dir)
    or die "Chdir to '$dir' failed: $!";
my $regressdir = getcwd();
$dir = "results";
chdir($dir)
    or die "Chdir to '$dir' failed: $!";

my ($user, $host) = split('@', $opts{h} || "", 2);
($user, $host) = ("root", $user) unless $host;

my @results;
if ($opts{l}) {
    my @latest;
    if ($host) {
	push @latest, "latest-$host/test.result";
	-f $latest[0]
	    or die "No latest test.result for $host";
    } else {
	@latest = glob("latest-*/test.result");
    }
    @results = map { (readlink(dirname($_))
	or die "Readlink latest '$_' failed: $!") . "/test.result" } @latest;
} else {
    @results = sort glob("*/test.result");
}

my (%t, %d);
foreach my $result (@results) {

    # parse result file
    my ($date, $short) = $result =~ m,((.+)T.+)/test.result,
	or next;
    $d{$date} = {
	short => $short,
	result => $result,
    };
    $d{$date}{setup} = "$date/setup.html" if -f "$date/setup.html";
    $_->{severity} *= .5 foreach values %t;
    my ($total, $pass) = (0, 0);
    open(my $fh, '<', $result)
	or die "Open '$result' for reading failed: $!";
    while (<$fh>) {
	chomp;
	my ($status, $test, $message) = split(" ", $_, 3);
	$t{$test}{$date}
	    and warn "Duplicate test '$test' at date '$date'";
	$t{$test}{$date} = {
	    status => $status,
	    message => $message,
	};
	my $severity =
	    $status eq 'PASS'   ? 1 :
	    $status eq 'SKIP'   ? 2 :
	    $status eq 'FAIL'   ? 5 :
	    $status eq 'NOEXIT' ? 6 :
	    $status eq 'NOTERM' ? 7 :
	    $status eq 'NORUN'  ? 8 : 10;
	$t{$test}{severity} += $severity;
	$total++ unless $status eq 'SKIP';
	$pass++ if $status eq 'PASS';
	my $logfile = dirname($result). "/logs/$test/make.log";
	$t{$test}{$date}{logfile} = $logfile if -f $logfile;
    }
    close($fh)
	or die "Close '$result' after reading failed: $!";
    $d{$date}{pass} = $pass / $total if $total;

    # parse version file
    my ($version, $diff, $dmesg);
    if ($host) {
	$version = "$date/version-$host.txt";
	$diff = "$date/diff-$host.txt";
	$dmesg = "$date/dmesg-$host.txt";
    } else {
	$version = (glob("$date/version-*.txt"))[0];
	($diff = $version) =~ s,/version-,/diff-,;
	($dmesg = $version) =~ s,/version-,/dmesg-,;
    }
    unless (-f $version) {
	# if host is specified, only print result for this one
	delete $d{$date} if $host;
	next;
    }
    $d{$date}{version} = $version;
    open($fh, '<', $version)
	or die "Open '$version' for reading failed: $!";
    while (<$fh>) {
	if (/^kern.version=(.*: (\w+ \w+ +\d+ .*))$/) {
	    $d{$date}{kernel} = $1;
	    $d{$date}{time} = $2;
	    <$fh> =~ /(\S+)/;
	    $d{$date}{kernel} .= "\n    $1";
	    $d{$date}{location} = $1;
	}
	/^hw.machine=(\w+)$/ and $d{$date}{arch} = $1;
    }
    $d{$date}{build} = $d{$date}{location} =~ /^deraadt@\w+.openbsd.org:/ ?
	"snapshot" : "custom";
    $d{$date}{diff} = $diff if -f $diff;
    $d{$date}{dmesg} = $dmesg if -f $dmesg;
}

my $htmlfile = $opts{l} ? "latest" : "regress";
$htmlfile .= "-$host" if $host;
$htmlfile .= ".html";
unlink("$htmlfile.new");
open(my $html, '>', "$htmlfile.new")
    or die "Open '$htmlfile.new' for writing failed: $!";
my $htmltitle = $opts{l} ? "Latest" : "Test";
my $bodytitle = $host ? ($opts{l} ? "latest $host" : $host) :
    ($opts{l} ? "latest" : "all");

print $html <<"HEADER";
<!DOCTYPE html>
<html>

<head>
  <title>OpenBSD Regress $htmltitle Results</title>
  <style>
    th { text-align: left; white-space: nowrap; }
    tr:hover {background-color: #e0e0e0}
    td.PASS {background-color: #80ff80;}
    td.FAIL {background-color: #ff8080;}
    td.SKIP {background-color: #8080ff;}
    td.NOEXIT, td.NOTERM, td.NORUN {background-color: #ffff80;}
    td.NOLOG, td.NOCLEAN, td.NOEXIST {background-color: #ffffff;}
    td.result, td.result a {color: black;}
  </style>
</head>

<body>
<h1>OpenBSD regress $bodytitle test results</h1>
<table>
  <tr>\n    <th>created at</th>
    <td>$now</td>
  </tr>
  <tr>\n    <th>test</th>
    <td><a href=\"run.html\">run</a></td>
  </tr>
</table>
HEADER

my @dates = reverse sort keys %d;
print $html "<table>\n";
print $html "  <tr>\n    <th>pass rate</th>\n";
foreach my $date (@dates) {
    my $pass = $d{$date}{pass};
    my $percent = "";
    $percent = sprintf("%d%%", 100 * $pass) if defined $pass;
    print $html "    <th>$percent</th>\n";
}
print $html "  <tr>\n    <th>test at date</th>\n";
foreach my $date (@dates) {
    my $short = $d{$date}{short};
    my $setup = $d{$date}{setup};
    $setup = join("/", map { uri_escape($_) } split("/", $setup)) if $setup;
    my $time = encode_entities($date);
    my $href = $setup ? "<a href=\"$setup\">" : "";
    my $enda = $href ? "</a>" : "";
    print $html "    <th title=\"$time\">$href$short$enda</th>\n";
}
print $html "  <tr>\n    <th>machine build</th>\n";
foreach my $date (@dates) {
    my $version = $d{$date}{version};
    unless ($version) {
	print $html "    <th/>\n";
	next;
    }
    my $kernel = encode_entities($d{$date}{kernel});
    my $build = $d{$date}{build};
    $version = join("/", map { uri_escape($_) } split("/", $version));
    my $diff = join("/", map { uri_escape($_) }
	split("/", $d{$date}{diff} || ""));
    my $href = "";
    $href = "<a href=\"$version\">" if $build eq "snapshot";
    $href = "<a href=\"$diff\">" if $build eq "custom" && $diff;
    my $enda = $href ? "</a>" : "";
    print $html "    <th title=\"$kernel\">$href$build$enda</th>\n";
}
print $html "  <tr>\n    <th>architecture</th>\n";
foreach my $date (@dates) {
    my $arch = $d{$date}{arch};
    unless ($arch) {
	print $html "    <th/>\n";
    }
    my $dmesg = join("/", map { uri_escape($_) }
	split("/", $d{$date}{dmesg} || ""));
    my $href = $dmesg ? "<a href=\"$dmesg\">" : "";
    my $enda = $href ? "</a>" : "";
    print $html "    <th>$href$arch$enda</th>\n";
}
print $html "  </tr>\n";

my $cvsweb = "http://cvsweb.openbsd.org/cgi-bin/cvsweb/src/regress/";
my @tests = sort { $t{$b}{severity} <=> $t{$a}{severity} || $a cmp $b }
    keys %t;
foreach my $test (@tests) {
    print $html "  <tr>\n    <th><a href=\"$cvsweb$test/\">$test</a></th>\n";
    foreach my $date (@dates) {
	my $status = $t{$test}{$date}{status} || "";
	my $class = " class=\"result $status\"";
	my $message = encode_entities($t{$test}{$date}{message});
	my $title = $message ? " title=\"$message\"" : "";
	my $logfile = uri_escape($t{$test}{$date}{logfile});
	my $href = $logfile ? "<a href=\"$logfile\">" : "";
	my $enda = $href ? "</a>" : "";
	print $html "    <td$class$title>$href$status$enda</td>\n";
    }
    print $html "  </tr>\n";
}
print $html "</table>\n";

print $html <<"FOOTER";
<table>
  <tr>\n    <th>PASS</th>
    <td>make regress passed</td>\n  </tr>
  <tr>\n    <th>FAIL</th>
    <td>make regress failed, string FAILED in test output</td>\n  </tr>
  <tr>\n    <th>SKIP</th>
    <td>make regress skipped itself, string SKIPPED in test output</td>\n  </tr>
  <tr>\n    <th>NOEXIT</th>
    <td>make regress did not exit with code 0, make failed</td>\n  </tr>
  <tr>\n    <th>NOTERM</th>
    <td>make regress did not terminate, aborted after timeout</td>\n  </tr>
  <tr>\n    <th>NORUN</th>
    <td>make regress did not run, execute make failed</td>\n  </tr>
  <tr>\n    <th>NOLOG</th>
    <td>create log file for make output failed</td>\n  </tr>
  <tr>\n    <th>NOCLEAN</th>
    <td>make clean before running test failed</td>\n  </tr>
  <tr>\n    <th>NOEXIST</th>
    <td>test directory not found</td>\n  </tr>
</table>
</body>

</html>
FOOTER

close($html)
    or die "Close '$htmlfile.new' after writing failed: $!";
rename("$htmlfile.new", "$htmlfile")
    or die "Rename '$htmlfile.new' to '$htmlfile' failed: $!";

system("gzip -f -c $htmlfile >$htmlfile.gz.new")
    and die "gzip $htmlfile failed: $?";
rename("$htmlfile.gz.new", "$htmlfile.gz")
    or die "Rename '$htmlfile.new.gz' to '$htmlfile.gz' failed: $!";
