Script for setting up kuubernetes cluster on VM's 
=============================================================================
All scriptes built for community knowledge purpose Clone the repositry link : 

Firstly install the Vagrant and VS Code on your PC. 

Link https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1_windows_amd64.msi

https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1_windows_amd64.msi 

Then install the vmware utility on your PC Link : 

https://releases.hashicorp.com/vagrant-vmware-utility/1.0.22/vagrant-vmware-utility_1.0.22_windows_amd64.msi 

Then install your favourite virtulization software e.g. Virtual Box or VMware workstation. 

Wait for provision of your VM's then check the status of kubernetes cluster. 

Sometimes theh cluster doesn't comes up automatically so run theses command to keep it up. 

To start using your cluster, you need to run the following as a regular user:

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  
sudo chown $(id -u):$(id -g) $HOME/.kube/config


Alternatively, if you are the root user, you can run:

export KUBECONFIG=/etc/kubernetes/admin.conf

Check your kubernetes clutser with below command -:

for root user -:

kubectl get nodes

for normal user -:

sudo kubectl get nodes

This is my first repositry on github so please support.