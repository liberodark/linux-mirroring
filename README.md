# Linux Mirroring
Sync for create mirror of linux


### For install scripts :

```
yum install git -y # For Centos
apt install git -y # For Debian
cd /opt/
git clone https://github.com/liberodark/linux-mirroring/
cd linux-mirroring/
chmod +x *.sh
```

### For make sync in auto :

Run in terminal :
```
crontab -e
```
Put in crontab :
```
* 19 * * * /opt/linux-mirroring/sync-manjaro.sh
* 20 * * * /opt/linux-mirroring/sync-debian.sh
* 22 * * * /opt/linux-mirroring/sync-debian-security.sh
* 23 * * * /opt/linux-mirroring/sync-centos.sh
```

### Linux Sync Script

Name | Arch | Size | Version | Status
---------------- |:------:|:---------:|:--------------:|:-------------:
**sync-manjaro.sh** | x86/x86_64 | 90 Go | All | Work
**sync-debian.sh** | x86_64 | 350 Go | All | Work
**sync-debian-security.sh** | x86_64 | 40 Go | All | Work
**sync-centos.sh** | x86_64| 100 Go | 7 | Work
