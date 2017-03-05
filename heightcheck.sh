leader=$(factom-cli get heights | grep Leader | cut -c 15-)
current=$(factom-cli get heights | grep Directory | cut -c 23-)
difference=$(($leader - $current))
if (($difference > 3))
  then
  sleep 10
  newcurrent=$(factom-cli get heights | grep Directory | cut -c 23-)
  if ((($newcurrent - $current) < 5 ))
    then
    pkill factomd
    sleep 10
    factomd
    #screen -dmS fctd factomd
    echo $(date) ": Restarted factomd" >> ~/restart.log
 fi
fi
