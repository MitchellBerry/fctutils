leader=$(factom-cli get heights | grep Leader | cut -c 15-)
current=$(factom-cli get heights | grep Directory | cut -c 23-)
difference=$(($leader - $current))
#TODO: Restart if no response from cli

if (($difference > 3))
  then
  sleep 10
  newcurrent=$(factom-cli get heights | grep Directory | cut -c 23-)
  if ((($newcurrent - $current) < 5 ))
    then
    pkill factomd
    sleep 10
    
    #open factomd as a normal bg process
    factomd
    
    #open in a detached screen session named fctd for later retrieval
    #screen -dmS fctd factomd
    
    echo $(date) ": Restarted factomd" >> ~/restart.log
 fi
fi
