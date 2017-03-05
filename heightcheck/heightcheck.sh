#!/usr/bin/env bash
#TODO: Deal with no response
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
#api method
#curl -X POST -H 'Content-Type: application/json' -d '{"params":{},"method":"heights","jsonrpc":"2.0", "id":"1"}' localhost:8088/v2
