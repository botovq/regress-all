export REGRESS_FAIL_EARLY=no
export TEST_SSH_UNSAFE_PERMISSIONS=yes

LOCAL_IF=bge0
LOCAL_MAC=2c:09:4d:00:04:b7

LOCAL_ADDR=10.188.27.47
FAKE_ADDR=10.188.27.188

LOCAL_ADDR6=fdd7:e83e:66bc:27::47
FAKE_ADDR6=fdd7:e83e:66bc:27::188

export LOCAL_IF LOCAL_MAC
export LOCAL_ADDR FAKE_ADDR
export LOCAL_ADDR6 FAKE_ADDR6

ftp_proxy=http://10.0.1.3:8000/
http_proxy=http://10.0.1.3:8000/

export ftp_proxy http_proxy