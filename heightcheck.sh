leader=$(factom-cli get heights | grep LeaderHeight | cut -c 15-)
current=$(factom-cli get heights | grep DirectoryBlockHeight | cut -c 23-)
difference=$(($leader - $current))

#echo Current Height: $current
#echo Leader Height: $leader
#echo Difference: $difference

if (($difference > 3))
  then
  sleep 60
  newcurrent=$(factom-cli get heights | grep DirectoryBlockHeight | cut -c 23-)
  echo $(date -u) ": Daemon behind leader height, checking if stalled..." >> ~/restart.log
  if ((($newcurrent - $current) < 5 ))
    then
    pkill factomd
    sleep 15
    #open factomd in a detached screen session to allow later retrieval
    screen -dmS fctd factomd
    echo $(date) ": Restarted factomd" >> ~/restart.log
    else
    echo $(date) ": False alarm, blocks still processing" >> ~/restart.log
 fi
fi

#api method
#curl -X POST -H 'Content-Type: application/json' -d '{"params":{},"method":"heights","jsonrpc":"2.0", "id":"1"}' localhost:8088/v2