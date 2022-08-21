#! /bin/bash
VIP_IP=$1
VIP_IP=$VIP_IP
INSTANCE_ID=$2
INSTANCE_ID=$INSTANCE_ID
cat <<EOF > /etc/keepalived/keepalived.conf
# Global Settings for notifications
global_defs {
    notification_email {
        id@domain.com     # Email address for notifications
    }
}
# Define the script used to check if haproxy is still working
vrrp_script check_apiserver {
  script "/etc/keepalived/check_apiserver.sh"
  interval 3
  weight -2
  fall 10
  rise 2
}
# Configuration for Virtual Interface
vrrp_instance LB_VIP {
    interface eth0
    state MASTER        # set to BACKUP on the peer machine
    priority 101        # set to  99 on the peer machine
    virtual_router_id 51
    unicast_src_ip 192.168.0.10 # My IP 
    unicast_peer {
        192.168.0.20 # peer IP 
        192.168.0.30 # peer IP 
    } 
    authentication {
        auth_type AH
        auth_pass myP@ssword	# Password for accessing vrrpd. Same on all devices
    }
    # The virtual ip address shared between the two loadbalancers
    virtual_ipaddress {
        $VIP_IP/32
    }
    # Use the Defined Script to Check whether to initiate a fail over
    track_script {
        check_apiserver.sh
    }
    notify_master /etc/keepalived/master.sh   
}

EOF

cat <<EOF >  /etc/keepalived/check_apiserver.sh
#!/bin/sh
APISERVER_VIP=$VIP_IP
APISERVER_DEST_PORT=80
errorExit() {
    echo "*** \$*" 1>&2
    exit 1
}
curl --silent --max-time 2 --insecure https://localhost:\${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://localhost:\${APISERVER_DEST_PORT}/"
if ip addr | grep -q \${APISERVER_VIP}; then
    curl --silent --max-time 2 --insecure https://\${APISERVER_VIP}:\${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://\${APISERVER_VIP}:\${APISERVER_DEST_PORT}/"
fi
EOF

sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf
sysctl -p

mkdir ~/.aws

cat << EOF > ~/.aws/credentials
[default]
aws_access_key_id=AKIARI64MQMR3Y3BPDPS
aws_secret_access_key=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
EOF

cat << EOF > /etc/keepalived/master.sh
#!/bin/bash
EIP=$VIP_IP
INSTANCE_ID=$INSTANCE_ID
aws ec2 disassociate-address --public-ip \$EIP
aws ec2 associate-address --public-ip \$EIP --instance-id \$INSTANCE_ID
EOF

chmod 700 /etc/keepalived/master.sh

