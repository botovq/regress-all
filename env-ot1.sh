export REGRESS_FAIL_EARLY=no
export TEST_SSH_UNSAFE_PERMISSIONS=yes

LOCAL_IF=em2
LOCAL_MAC=00:1b:21:60:58:28

REMOTE_SSH=ot2
REMOTE_IF=em1
REMOTE_MAC=90:e2:ba:d8:67:2d
FAKE_MAC=12:34:56:78:9a:bc
OTHER_IF=em0

TARGET_SSH=ot3
TARGET_IF=em3

LOCAL_ADDR=10.188.81.21
REMOTE_ADDR=10.188.81.22
FAKE_ADDR=10.188.81.188
OTHER_ADDR=10.188.82.22
OTHER_FAKE_ADDR=10.188.82.188
TARGET_ADDR=10.188.82.23
FAKE_NET=10.188.80.0/24
FAKE_NET_ADDR=10.188.80.188

LOCAL_ADDR6=fdd7:e83e:66bc:81::21
REMOTE_ADDR6=fdd7:e83e:66bc:81::22
FAKE_ADDR6=fdd7:e83e:66bc:81::188
OTHER_ADDR6=fdd7:e83e:66bc:82::22
OTHER_FAKE1_ADDR6=fdd7:e83e:66bc:82::dead
OTHER_FAKE2_ADDR6=fdd7:e83e:66bc:82::beef
TARGET_ADDR6=fdd7:e83e:66bc:82::23
FAKE_NET6=fdd7:e83e:66bc:80::/64
FAKE_NET_ADDR6=fdd7:e83e:66bc:80::188

export LOCAL_IF LOCAL_MAC
export REMOTE_SSH REMOTE_IF REMOTE_MAC FAKE_MAC OTHER_IF
export TARGET_SSH TARGET_IF
export LOCAL_ADDR REMOTE_ADDR FAKE_ADDR
export OTHER_ADDR OTHER_FAKE_ADDR
export LOCAL_ADDR6 REMOTE_ADDR6 FAKE_ADDR6
export OTHER_ADDR6 OTHER_FAKE1_ADDR6 OTHER_FAKE2_ADDR6
export FAKE_NET FAKE_NET_ADDR
export FAKE_NET6 FAKE_NET_ADDR6 TARGET_ADDR

SRC_IF=em2
SRC_MAC=00:1b:21:60:58:28
PF_IFIN=em0
PF_IFOUT=em1
PF_MAC=90:e2:ba:d8:67:2c
PF_SSH=ot2
RT_SSH=ot3
ECO_SSH=ot4

SRC_OUT=10.188.81.21
PF_IN=10.188.81.22
PF_OUT=10.188.82.22
RT_IN=10.188.82.23
RT_OUT=10.188.83.23
ECO_IN=10.188.83.24
ECO_OUT=10.188.84.24
RDR_IN=10.188.85.188
RDR_OUT=10.188.86.188
AF_IN=10.188.87.36		# /24 must be dec(ECO_IN6/120)
RTT_IN=10.188.88.24
RTT_OUT=10.188.89.24
RPT_IN=10.188.90.21
RPT_OUT=10.188.91.21

SRC_OUT6=fdd7:e83e:66bc:81::21
PF_IN6=fdd7:e83e:66bc:81::22
PF_OUT6=fdd7:e83e:66bc:82::22
RT_IN6=fdd7:e83e:66bc:82::23
RT_OUT6=fdd7:e83e:66bc:83::23
ECO_IN6=fdd7:e83e:66bc:83::24
ECO_OUT6=fdd7:e83e:66bc:84::24
RDR_IN6=fdd7:e83e:66bc:85::188
RDR_OUT6=fdd7:e83e:66bc:86::188
AF_IN6=fdd7:e83e:66bc:87::18	# /120 must be hex(ECO_IN/24)
RTT_IN6=fdd7:e83e:66bc:88::24
RTT_OUT6=fdd7:e83e:66bc:89::24
RPT_IN6=fdd7:e83e:66bc:90::21
RPT_OUT6=fdd7:e83e:66bc:91::21

export SRC_IF SRC_MAC PF_IFIN PF_IFOUT PF_MAC PF_SSH RT_SSH ECO_SSH
export SRC_OUT PF_IN PF_OUT RT_IN RT_OUT ECO_IN ECO_OUT
export RDR_IN RDR_OUT AF_IN RTT_IN RTT_OUT RPT_IN RPT_OUT
export SRC_OUT6 PF_IN6 PF_OUT6 RT_IN6 RT_OUT6 ECO_IN6 ECO_OUT6
export RDR_IN6 RDR_OUT6 AF_IN6 RTT_IN6 RTT_OUT6 RPT_IN6 RPT_OUT6

SRC_OUT_IF=em2
IPS_IN_IF=em0
IPS_OUT_IF=em1
RT_IN_IF=em0
RT_OUT_IF=em1
ECO_IN_IF=em0
IPS_SSH=ot2

export SRC_OUT_IF IPS_IN_IF IPS_OUT_IF RT_IN_IF RT_OUT_IF ECO_IN_IF IPS_SSH

LEFT_SSH=ot3
LEFT_ADDR=10.188.43.23
LEFT_ADDR6=fdd7:e83e:66bc:43::23

RIGHT_SSH=ot4
RIGHT_ADDR=10.188.43.24
RIGHT_ADDR6=fdd7:e83e:66bc:43::24

export LEFT_SSH LEFT_ADDR LEFT_ADDR6
export RIGHT_SSH RIGHT_ADDR RIGHT_ADDR6
