LOCAL_IF=ix0
LOCAL_MAC=00:1b:21:0d:db:8f
LOCAL_ADDR=10.3.45.34
LOCAL_NET=10.3.45.34/24
LOCAL_ADDR6=fdd7:e83e:66bc:0345::34
LOCAL_NET6=fdd7:e83e:66bc:0345::34/64

REMOTE_IF=ix1
REMOTE_MAC=00:1b:21:0d:db:9b
REMOTE_ADDR=10.3.45.35
REMOTE_ADDR6=fdd7:e83e:66bc:0345::35
REMOTE_SSH=ot15

LINUX_ADDR=10.3.46.36
LINUX_ADDR6=fdd7:e83e:66bc:0346::36
LINUX_FORWARD_ADDR=10.3.46.36
LINUX_FORWARD_ADDR6=fdd7:e83e:66bc:0346::36
LINUX_RELAY_ADDR=10.3.34.34
LINUX_RELAY_ADDR6=fdd7:e83e:66bc:0334::34
LINUX_LINUX_ADDR=10.3.36.36
LINUX_LINUX_ADDR6=fdd7:e83e:66bc:336::36
LINUX_LEFT_SSH=perform@lt13

LINUX_RELAY_LOCAL_ADDR=10.3.56.35
LINUX_RELAY_LOCAL_ADDR6=fdd7:e83e:66bc:0356::35
LINUX_RELAY_REMOTE_ADDR=10.3.46.34
LINUX_RELAY_REMOTE_ADDR6=fdd7:e83e:66bc:0346::34
LINUX_RIGHT_SSH=perform@lt16

LOCAL_IPSEC_ADDR=10.4.34.34
LOCAL_IPSEC_ADDR6=fdd7:e83e:66bc:0434::34
REMOTE_IPSEC_ADDR=10.4.56.35
REMOTE_IPSEC_ADDR6=fdd7:e83e:66bc:0456::35
LINUX_IPSEC_ADDR=10.4.56.36
LINUX_IPSEC_ADDR6=fdd7:e83e:66bc:0456::36

LINUX_VEB_ADDR=10.5.0.36
LINUX_VEB_ADDR6=fdd7:e83e:66bc:0500::36

PFSYNC_IF=ix5
PFSYNC_ADDR=10.3.14.34
PFSYNC_PEER_IF=ixl1
PFSYNC_PEER_ADDR=10.3.14.51
PFSYNC_SSH=ot31

LOCAL_ADDR_RANGE=10.3.46.40
LOCAL_ADDR6_RANGE=fdd7:e83e:66bc:346::40
REMOTE_ADDR_RANGE=10.3.56.50
REMOTE6_ADDR_RANGE=fdd7:e83e:66bc:356::50
LINUX_ADDR_RANGE=10.3.46.60
LINUX_ADDR6_RANGE=fdd7:e83e:66bc:346::60

export LOCAL_IF LOCAL_MAC LOCAL_ADDR LOCAL_NET LOCAL_ADDR6 LOCAL_NET6
export REMOTE_IF REMOTE_MAC REMOTE_ADDR REMOTE_ADDR6
export REMOTE_SSH
export LINUX_ADDR LINUX_ADDR6 LINUX_FORWARD_ADDR LINUX_FORWARD_ADDR6
export LINUX_RELAY_ADDR LINUX_RELAY_ADDR6 LINUX_LINUX_ADDR LINUX_LINUX_ADDR6
export LINUX_LEFT_SSH
export LINUX_RELAY_LOCAL_ADDR LINUX_RELAY_LOCAL_ADDR6
export LINUX_RELAY_REMOTE_ADDR LINUX_RELAY_REMOTE_ADDR6
export LINUX_RIGHT_SSH
export LOCAL_IPSEC_ADDR REMOTE_IPSEC_ADDR LINUX_IPSEC_ADDR
export LOCAL_IPSEC_ADDR6 REMOTE_IPSEC_ADDR6 LINUX_IPSEC_ADDR6
export LINUX_VEB_ADDR LINUX_VEB_ADDR6
export PFSYNC_IF PFSYNC_ADDR PFSYNC_PEER_IF PFSYNC_PEER_ADDR PFSYNC_SSH
export LOCAL_ADDR_RANGE LOCAL_ADDR6_RANGE REMOTE_ADDR_RANGE REMOTE_ADDR6_RANGE
export LINUX_ADDR_RANGE LINUX_ADDR6_RANGE
