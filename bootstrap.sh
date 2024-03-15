echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.100 kmaster.example.com kmaster
172.16.16.101 kworker1.example.com kworker1
172.16.16.102 kworker2.example.com kworker2
EOF

# Install docker from Docker-ce repository
echo "[TASK 2] Register System with RHEL Repo"
subscription-manager register --username [your-rhel-subscriptionaccount] --password [your-rhel-subscription-password] --auto-attach
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf update -y && dnf install -y iptables-legacy
alternatives --set iptables /usr/sbin/iptables-legacy
dnf install -y -q yum-utils device-mapper-persistent-data lvm2 > /dev/null 2>&1



# Disable SELinux
echo "[TASK 3] Disable SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Stop and disable firewalld
echo "[TASK 4] Stop and Disable firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

# Add sysctl settings
echo "[TASK 5] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-iptables=1
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables=1
EOF
sysctl --system >/dev/null 2>&1

modprobe overlay
modprobe br_netfilter

echo -e overlay\\nbr_netfilter > /etc/modules-load.d/k8s.conf 2>&1

# Disable swap
echo "[TASK 6] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Add CRI-Runtime
echo "[TASK 7] Adding CRI-O Runtime"
export VERSION=1.28
export OS=CentOS_9_Stream
curl -L -o /etc/yum.repos.d/libcontainers-stable.repo https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:
curl -L -o /etc/yum.repos.d/libcontainers-stable-cri-o.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/devel:kubic:libcontainers:stable:cri-o:$VERSION.repo
dnf install crio -y
systemctl enable --now crio
echo "CRI-O Runtime installed and enabled"

# Add yum repo file for Kubernetes
echo "[TASK 8] Add repo file for kubernetes"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
EOF

## Install Kubernetes
echo "[TASK 9] Install Kubernetes (kubeadm, kubelet and kubectl)"
yum install -y -q kubeadm kubelet kubectl > /dev/null 2>&1

## Start and Enable kubelet service
echo "[TASK 10] Enable and start kubelet service"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1

# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 12] Set root password"
echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc
