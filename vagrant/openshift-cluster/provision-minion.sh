#!/bin/bash

minion_name=$1

echo 'export PATH=/vagrant/openshift:$PATH' >> /root/.bashrc
echo 'export PATH=/vagrant/openshift:$PATH' >> /home/vagrant/.bashrc

PATH=/vagrant/openshift:$PATH

mkdir -p ~/.kube/
ln -s /vagrant/openshift/openshift.local.config/master/admin.kubeconfig ~/.kube/config
mkdir -p /home/vagrant/.kube/
ln -s /vagrant/openshift/openshift.local.config/master/admin.kubeconfig /home/vagrant/.kube/config

yum install -y https://rdoproject.org/repos/rdo-release.rpm
yum install -y openvswitch git golang bridge-utils

pushd /vagrant/
if [ -d openshift-sdn ]; then
  pushd openshift-sdn
  git fetch origin
  git reset --hard origin/master
else
  git clone https://github.com/openshift/openshift-sdn
  pushd openshift-sdn
fi
make clean
make
make install

popd
popd

systemctl enable openvswitch
systemctl start openvswitch

# Create systemd service
cat <<EOF > /usr/lib/systemd/system/openshift-node.service
[Unit]
Description=OpenShift Node
Requires=network.service
After=docker.service network.service

[Service]
ExecStart=/vagrant/openshift/openshift start node --config=/vagrant/openshift/openshift.local.config/node-${minion_name}/node-config.yaml
Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable openshift-node.service
systemctl start openshift-node.service
