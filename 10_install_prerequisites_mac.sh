#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#       __________  __ ___       _____    ________            
#      / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____
#     / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/
#    / /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) 
#    \____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  
#                                              /_/            
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------"
# Installing Mac prerequisites for CP4WAIOPS
#
# Watson AIOps 
#
# ©2022 nikh@ch.ibm.com
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"


echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  🚀 CloudPak for Watson AI OPS - Install Mac Prerequisites"
echo "  "
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  "






echo "🚀 Installing prerequisites"
echo ""

    echo "   🧰 Install Tools"
    echo ""  
    
        echo "      📥 Install Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                
        echo "      📥 Install Ansible"
        brew install ansible

        echo "      📥 Install Ansible Kubernetes"
        ansible-galaxy collection install community.kubernetes:2.0.1
        ansible-galaxy collection install kubernetes.core:2.3.0
        ansible-galaxy collection install cloud.common
        pip install openshift pyyaml kubernetes 
        
        echo "      📥 Install kafkacat"
        brew install kafkacat
        
        echo "      📥 Install node"
        brew install node
        
        echo "      📥 Install wget"
        brew install wget

        echo "      📥 Install elasticdump"
        npm install elasticdump -g
        
        echo "      📥 Install jq"
        brew install jq

        echo "      📥 Install cloudctl"
        curl -L https://github.com/IBM/cloud-pak-cli/releases/latest/download/cloudctl-darwin-amd64.tar.gz -o cloudctl-darwin-amd64.tar.gz
        tar xfvz cloudctl-darwin-amd64.tar.gz
        sudo mv cloudctl-darwin-amd64 /usr/local/bin/cloudctl
        rm cloudctl-darwin-amd64.tar.gz

        
    echo ""  
    echo "" 
    echo ""  
    echo "   🧰 Install OpenShift Client"
    echo ""  
        wget https://github.com/openshift/okd/releases/download/4.7.0-0.okd-2021-07-03-190901/openshift-client-mac-4.7.0-0.okd-2021-07-03-190901.tar.gz -O oc.tar.gz
        tar xfzv oc.tar.gz
        sudo mv oc /usr/local/bin
        sudo mv kubectl /usr/local/bin
        rm oc.tar.gz
        rm README.md

    echo ""  
    echo ""  
    echo ""  
    echo "   🧰 Install K9s"
    echo ""  
        wget https://github.com/derailed/k9s/releases/download/v0.24.15/k9s_Darwin_x86_64.tar.gz
        tar xfzv k9s_Darwin_x86_64.tar.gz
        sudo mv k9s /usr/local/bin
        rm LICENSE
        rm README.md

        



echo ""  
echo ""  
echo "Installing prerequisites DONE..."



echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo " ✅ Prerequisites Installed"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"



