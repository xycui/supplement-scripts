# Supplement Scripts
Include system supplement scripts for MacOSX/Windows.
## Network
### Wifi Reconnect
wifi reconnect script([osx](/osx/wifi_auto_reconn.sh)) will 

**Usage**
```shell
wifi_auto_reconn.sh {SSID}
```
**Crontab**
```shell
crontab -e
* * * * * sh {repo_path}/wifi_auto_reconn.sh {SSID}
```