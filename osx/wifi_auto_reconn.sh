#!/bin/bash
source /etc/profile
wifiOnText='Wi-Fi Power (en1): On'
wifiDevice='en1'
wifiSSID=''

wifiIsConn(){
    airPortInfo=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep $wifiSSID)
    echo $airPortInfo
    if [ -n "$airPortInfo" ]
    then
        return 1
    else
        return 0
    fi
}

isWifiOn(){
    wifiStatus=$(networksetup -getairportpower $wifiDevice)
    if [ "$wifiStatus" = "$wifiOnText" ]
    then
        return 1
    else
        return 0
    fi
}

turnWifiOn(){
    echo $(networksetup -setairportpower $wifiDevice on)
}

turnWifiOff(){
    echo $(networksetup -setairportpower $wifiDevice off)
}

connWifi(){
    networksetup -setairportnetwork en1 $wifiSSID
}

main(){
    # check wifi ssid from argument
    wifiSSID=$1
    if [[ $# -eq 0 || -z "$wifiSSID" ]]
    then
        echo 'WIFI SSID is not provided'
        return
    fi
    echo $wifiSSID

    # check wifi is connected
    wifiIsConn
    wifiConn=$?
    if [ $wifiConn -eq 1 ]
    then
        echo 'wifi connected'
        return
    fi

    isWifiOn
    wifiOn=$?
    if [ $wifiOn -eq 1 ]
    then
        turnWifiOff
        echo 'ready to turn on wifi after 5 seconds'
        sleep 5s
    fi

    turnWifiOn
    sleep 5s
    wifiIsConn
    wifiConn=$?
    if [ $wifiConn -eq 0 ]
    then
        echo 'connecting to wifi $wifiSSID'
        connWifi
    fi
}

home_dir=`echo ~`
main $@ > "$home_dir/Desktop/wifi_auto_reconnn.txt"