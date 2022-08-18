#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#       __________  __ ___       _____    ________            
#      / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____
#     / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/
#    / /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) 
#    \____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  
#                                              /_/            
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------"
#  CP4WAIOPS v3.4.1 - CP4WAIOPS Installation
#
#
#  ©2022 nikh@ch.ibm.com
# ---------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------"

# ---------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------"
# Do Not Modify Below
# ---------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------"

#export ANSIBLE_DISPLAY_SKIPPED_HOSTS=false

clear

echo "*****************************************************************************************************************************"
echo "*****************************************************************************************************************************"
echo "*****************************************************************************************************************************"
echo "*****************************************************************************************************************************"
echo "  "
echo "  🐥 CloudPak for Watson AIOps v3.4.1 - CP4WAIOPS Configurations"
echo "  "
echo "*****************************************************************************************************************************"
echo "*****************************************************************************************************************************"
echo "*****************************************************************************************************************************"
echo "  "
echo "  "




export TEMP_PATH=~/aiops-install




runPlaybook () {
      echo ""
      echo ""
      echo ""
      echo ""
      echo ""
      echo "*****************************************************************************************************************************"
      echo "--------------------------------------------------------------------------------------------"
      echo " 🚀  Run Install with Configuration: $ANSIBLE_CONFIGURATION" 
      echo "--------------------------------------------------------------------------------------------"
      echo "*****************************************************************************************************************************"
      echo ""

      FILE=./configs/$ANSIBLE_CONFIGURATION.yaml
      if test -f "./ansible/$FILE"; then
            echo "✅ Configuration found..."
            echo ""
            echo ""
            if [[ $ANSIBLE_CONFIGURATION =~ "01_AIManager-install" ]] || [[ $ANSIBLE_CONFIGURATION =~ "04_eventmanager-install" ]] || [[ $ANSIBLE_CONFIGURATION =~ "05_InfraManagement-install" ]] || [[ $ANSIBLE_CONFIGURATION =~ "09_AIManager-only" ]];  
            then
                  echo ""
                  echo ""
                  echo "  Enter CP4WAIOPS Pull token: "
                  read TOKEN
                  ansible-playbook $FILE -e CP_ENTITLEMENT_KEY=$TOKEN
            else
                  ansible-playbook ./ansible/00_cp4waiops-install.yaml -e config_file_path=$FILE  -e CP_ENTITLEMENT_KEY=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJJQk0gTWFya2V0cGxhY2UiLCJpYXQiOjE1Nzg0NzQzMjgsImp0aSI6IjRjYTM3ODkwMzExNjQxZDdiMDJhMjRmMGMxMWMwYmZhIn0.Z-rqfSLJA-R-ow__tI3RmLx4m9EH-abvdc53DYEkbYY
            fi

      else
            echo "❌ Config $FILE doesn't exist. Try again...."
            echo ""
      fi
      echo ""
      echo ""
      echo ""
      echo ""
      echo "*****************************************************************************************************************************"
      echo "--------------------------------------------------------------------------------------------"
      echo " ✅  DONE" 
      echo "--------------------------------------------------------------------------------------------"
      echo "*****************************************************************************************************************************"
      echo ""
}



until [ "$selection" = "0" ]; do
  
      clear

      echo "*****************************************************************************************************************************"
      echo "*****************************************************************************************************************************"
      echo "      __________  __ ___       _____    ________            "
      echo "     / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____"
      echo "    / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/"
      echo "   / /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) "
      echo "   \____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  "
      echo "                                             /_/            "
      echo ""
      echo "*****************************************************************************************************************************"
      echo " 🐥 CloudPak for Watson AIOPs - CONFIGURATIONS"
      echo "*****************************************************************************************************************************"
      echo ""

      echo "-----------------------------------------------------------------------"
      echo "  🐥  Available Installation Configurations"
      echo "  "

      ls -1 ./ansible/configs | sed 's/.yaml//'| sed 's/^/       /'



      echo "  "
      echo "  "
      echo "-----------------------------------------------------------------------"
      echo "  ❌    0  -  Exit"



      echo ""
      echo ""
      echo "  🚀 Copy and paste the name of the Playbook you want to run below: "
      read selection
      echo ""

      if [ $selection != "0" ];  then
            export ANSIBLE_CONFIGURATION=$selection
            runPlaybook

            read -p "Press Enter to continue..."
            clear 
      fi
done


