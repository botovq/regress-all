export REGRESS_FAIL_EARLY=no
export TEST_SSH_UNSAFE_PERMISSIONS=yes

LOCAL_IF=mcx1
LOCAL_MAC=b8:59:9f:0e:57:55

LOCAL_ADDR=10.188.31.31
FAKE_ADDR=10.188.31.188

LOCAL_ADDR6=fdd7:e83e:66bc:31::31
FAKE_ADDR6=fdd7:e83e:66bc:31::188

export LOCAL_IF LOCAL_MAC
export LOCAL_ADDR FAKE_ADDR
export LOCAL_ADDR6 FAKE_ADDR6

ftp_proxy=http://10.0.1.3:8000/
http_proxy=http://10.0.1.3:8000/
https_proxy=http://10.0.1.3:8000/
export ftp_proxy http_proxy https_proxy
