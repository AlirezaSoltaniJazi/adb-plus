#!/bin/bash

# Examples
# ./adb+ version
# ./adb+ install divar.apk
# ./adb+ uninstall ir.divar

adb devices | while read line
do
    if [ ! "$line" = "" ] && [ `echo $line | awk '{print $2}'` = "device" ]
    then
        device=`echo $line | awk '{print $1}'`
        echo "$device $@ ..."
        adb -s $device $@ 2>&1 | while read adb_output
        do
            echo "$adb_output"
            if [[ "$adb_output" == *"Exception occurred while executing:"* ]] || [[ "$adb_output" == *"Failure"* ]]
            then
                echo "Error occurred while executing adb command on device $device"
                break
            fi
        done
    else
      echo Somthing goes wrong!
    fi
done
