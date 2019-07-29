# linux-mirroring
Sync for create mirror of linux


For install scripts :

```
yum install git -y # For Centos
apt install git -y # For Debian
cd /opt/
git clone https://github.com/liberodark/linux-mirroring/
cd linux-mirroring/
chmod +x *.sh
```

For make sync in auto :

Run in terminal :
```
crontab -e
```
Put in crontab :
```
* 19 * * * /opt/linux-mirroring/sync-manjaro.sh
* 20 * * * /opt/linux-mirroring/sync-debian.sh
* 22 * * * /opt/linux-mirroring/sync-debian-security.sh
```
