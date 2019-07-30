# Linux Mirroring
Sync for create mirror of linux


### For install scripts :

```
yum install git -y # For Centos
apt install git -y # For Debian
pamac install git # For Manjaro
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
**sync-centos.sh** | x86_64| 90 Go | 7 | Work


### Exemple of Linux Repo

Name | Version | OS
---------------- |:------:|:---------:
**Server = http://domain.com/manjaro/stable/$repo/$arch** | 19.x | Manjaro
**deb http://domain.com/debian/ jessie main contrib non-free** | 8.x | Debian
**deb http://domain.com/debian/ stretch main contrib non-free** | 9.x | Debian
**deb http://domain.com/debian/ buster main contrib non-free** | 10.x | Debian
**deb http://domain.com/debian/ bullseye main contrib non-free** | 11.x | Debian
**baseurl=http://domain.com/centos/$releasever/os/$basearch/** | 7.x | Centos


### Install Repo :

#### Debian

```
echo "deb http://domain.com/debian/ jessie main contrib non-free" >> /etc/apt/sources.list
echo "deb http://domain.com/debian-security/ jessie/updates main contrib non-free" >> /etc/apt/sources.list
```
Manually remove and edit file :
```
rm /etc/apt/sources.list
nano /etc/apt/sources.list
```
Copy and past in file :
```
deb http://domain.com/debian/ jessie main contrib non-free
deb http://domain.com/debian-security/ jessie/updates main contrib non-free
```

#### Manajro 

Manually remove and edit file :
```
rm /etc/pacman.d/mirrorlist
nano /etc/pacman.d/mirrorlist
```
Copy and past in file :
```
Server = http://domain.com/manjaro/stable/$repo/$arch
```

#### Centos 

Manually remove and edit file :
```
rm /etc/yum.repos.d/*.repo
nano /etc/yum.repos.d/myrepo.repo
```
Copy and past in file :
```
[base]
name=CentOS-$releasever - Base
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
baseurl=http://domain.com/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates 
[updates]
name=CentOS-$releasever - Updates
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
baseurl=http://domain.com/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
baseurl=http://domain.com/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
baseurl=http://domain.com/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
```
