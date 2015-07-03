#!/bin/bash

MASTER_IP=$1
MASTER_NAME=$2
NUM_MINIONS=$3

echo 'export PATH=/vagrant/openshift:$PATH' >> /root/.bashrc
echo 'export PATH=/vagrant/openshift:$PATH' >> /home/vagrant/.bashrc

PATH=/vagrant/openshift:$PATH

if ! grep ${MASTER_IP} /etc/hosts; then
  echo "${MASTER_IP} ${MASTER_NAME}" >> /etc/hosts
fi

echo "Downloading OpenShift binaries..."
mkdir /vagrant/openshift /tmp/openshift 2> /dev/null
curl --retry 999 --retry-max-time 0 \
  -sSL https://github.com/openshift/origin/releases/download/v1.0.1/openshift-origin-v1.0.1-1b60195-linux-amd64.tar.gz | \
  tar xzv -C /tmp/openshift
mv /tmp/openshift/* /vagrant/openshift/ 2> /dev/null

SERVER_CONFIG_DIR="/vagrant/openshift/openshift.local.config"
VOLUMES_DIR="/var/lib/openshift/openshift.local.volumes"
MASTER_CONFIG_DIR="${SERVER_CONFIG_DIR}/master"
CERT_DIR="${MASTER_CONFIG_DIR}"

/vagrant/openshift/openshift admin create-master-certs \
  --overwrite=false \
  --cert-dir=${CERT_DIR} \
  --master=https://${MASTER_IP}:8443 \
  --hostnames=${MASTER_IP},${MASTER_NAME}

# Certs for nodes
for (( i=0; i<${NUM_MINIONS}; i++)); do
  minion_ip="172.28.128.$(expr 5 + $i)"
  if [ "$i" -gt 0 ]; then
    node_list="$node_list,"
  fi
  node_list="$node_list$minion_ip"
  /vagrant/openshift/openshift admin create-node-config \
    --node-dir="${SERVER_CONFIG_DIR}/node-${minion_ip}" \
    --node="${minion_ip}" \
    --hostnames="${minion_ip}" \
    --master="https://${MASTER_IP}:8443" \
    --node-client-certificate-authority="${CERT_DIR}/ca.crt" \
    --certificate-authority="${CERT_DIR}/ca.crt" \
    --signer-cert="${CERT_DIR}/ca.crt" \
    --signer-key="${CERT_DIR}/ca.key" \
    --signer-serial="${CERT_DIR}/ca.serial.txt" \
    --volume-dir="${VOLUMES_DIR}" \
    --network-plugin=redhat/openshift-ovs-subnet
done

/vagrant/openshift/openshift start master --master=${MASTER_IP} --cors-allowed-origins=.* \
  --etcd-dir=/var/lib/openshift/openshift.local.etcd \
  --nodes=${node_list} \
  --network-plugin=redhat/openshift-ovs-subnet \
  --write-config=/vagrant/openshift/openshift.local.config/master

# Create systemd service
cat <<EOF > /usr/lib/systemd/system/openshift-master.service
[Unit]
Description=OpenShift Master
Requires=docker.service network.service
After=network.service

[Service]
ExecStart=/vagrant/openshift/openshift start master --config=/vagrant/openshift/openshift.local.config/master/master-config.yaml
WorkingDirectory=/vagrant/openshift/

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable openshift-master.service
systemctl start openshift-master.service

while true; do
  curl -k -s -f -o /dev/null --connect-timeout 1 https://localhost:8443/healthz/ready && break || sleep 1
done

mkdir -p ~/.kube/
ln -s /vagrant/openshift/openshift.local.config/master/admin.kubeconfig ~/.kube/config
mkdir -p /home/vagrant/.kube/
ln -s /vagrant/openshift/openshift.local.config/master/admin.kubeconfig /home/vagrant/.kube/config

/vagrant/openshift/oadm policy add-cluster-role-to-user cluster-admin admin
oadm router --credentials=/vagrant/openshift/openshift.local.config/master/openshift-router.kubeconfig
oadm registry --credentials=/vagrant/openshift/openshift.local.config/master/openshift-registry.kubeconfig

