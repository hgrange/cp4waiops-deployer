#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT MODIFY BELOW
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------------------------------------------
#  Launch Injection
#------------------------------------------------------------------------------------------------------------------------------------
echo "   "
echo "   "
echo "   "
echo "   "
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀  Launching Event Injection" 
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"

for actFile in $(ls -1 $WORKING_DIR_EVENTS | grep "json"); 
do 

#------------------------------------------------------------------------------------------------------------------------------------
#  Prepare the Data
#------------------------------------------------------------------------------------------------------------------------------------

      echo "      ------------------------------------------------------------------------------------------------------------------------------------"
      echo "       🌏  Injecting Event Data from File: ${actFile}" 
      echo "           Quit with Ctrl-Z"
      echo "      ------------------------------------------------------------------------------------------------------------------------------------"


      EVENTS_SECONDS=10
      OS=$(uname -s | tr '[:upper:]' '[:lower:]')




      while IFS= read -r line
      do
            ((EVENTS_SECONDS++))
            EVENTS_SECONDS=$((EVENTS_SECONDS+60))

            if [ "${OS}" == "darwin" ]; then
                  # Suppose we're on Mac
                  export EVENTS_SECONDS_SKEW="-v+"$EVENTS_SECONDS"S"
            else
                  # Suppose we're on a Linux flavour
                  export EVENTS_SECONDS_SKEW=-d"+"$EVENTS_SECONDS" seconds"
            fi

echo "DATE_FORMAT_EVENTS:"$DATE_FORMAT_EVENTS
echo "EVENTS_SECONDS_SKEW:"$EVENTS_SECONDS_SKEW


            # Get timestamp in ELK format
            export my_timestamp=$(date $EVENTS_SECONDS_SKEW $DATE_FORMAT_EVENTS)".000Z"
            
            #echo $my_timestamp
            # Replace in line
            line=${line//MY_TIMESTAMP/$my_timestamp}
            line=${line//\"/\\\"}

            export c_string=$(echo "curl \"https://$DATALAYER_ROUTE/irdatalayer.aiops.io/active/v1/events\" --insecure --silent -X POST -u \"${USER_PASS}\" -H 'Content-Type: application/json' -H 'x-username:admin' -H 'x-subscription-id:cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d \"${line}\"")
            export result=$(eval $c_string)
            #export result=$(curl "https://$DATALAYER_ROUTE/irdatalayer.aiops.io/active/v1/events" --insecure --silent -X POST -u "${USER_PASS}" -H 'Content-Type: application/json' -H "x-username:admin" -H "x-subscription-id:cfd95b7e-3bc7-4006-a4a8-a73a79c71255" -d "${line}")
            myId=$(echo $result|jq ".deduplicationKey")
            echo "       DONE:$myId"
            #echo "       DONE:$result"

      done < "$WORKING_DIR_EVENTS/$actFile"
      echo "          ✅ OK"
      echo " "

done


