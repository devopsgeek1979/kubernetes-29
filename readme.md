Script for setting up kuubernetes cluster on VM's 
=============================================================================
All scriptes built for community knowledge purpose Clone the repositry link below : 

https://github.com/devopsgeek1979/kubernetes-29.git

Firstly install the Vagrant and VS Code on your PC. 

Vagrant Link https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1_windows_amd64.msi

Git for Windows Link 64 Bit : https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe

VS Code Link : https://vscode.download.prss.microsoft.com/dbazure/download/stable/863d2581ecda6849923a2118d93a088b0745d9d6/VSCode-win32-x64-1.87.2.zip

VMware utility on your PC Link : 

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

This is my first repositry on github so please support. 🙂 🙂 🙂 🙂 🙂 

Enjoy 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 🤙 

Feel free to contact if you have any doubts. 🙏 🙏 🙏 🙏 🙏 🙏
