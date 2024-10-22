#!/bin/bash
# Examples
# ./adb+ version
# ./adb+ install divar.apk
# ./adb+ uninstall ir.divar
# ./adb+ "R58R91RFQ2F,R9WT10GP09B" uninstall ir.divar

# Check if devices are provided manually
if [[ "$1" == *","* ]]; then
    # Manual device input
    DEVICES=$(echo $1 | tr ',' ' ')
    shift # Remove the first argument, which is the devices list
else
    # Automatic device detection
    DEVICES=$(adb devices | grep -w device | awk '{print $1}')
fi

# Loop through devices
for device in $DEVICES
do
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
    sleep 2
done
