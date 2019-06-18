---
title: "VirtualBox VMs"
author:
  - name: Wen-Ching Calvin Chan, Ph.D.
    email: wenching.chan@gmail.com
output:
  html_document:
    theme: united
    highlight: tango
    number_sections: true
    df_print: paged
    toc: true
    toc_depth: 3
    toc_float:
      collapsed: true
      smooth_scroll: false
    keep_md: true
always_allow_html: yes
---

# VirtualBox VMs

***

## Tips

- Use HOST (default: LEFT command(⌘)) to release mouse from a VM
- For CentOS/Ubuntu, ⇧ (Shift) +  ctrl + C/V for Copy and Paste, respectively
- Shared Clipboard / Drag'nDrop
    - Guest VM >> Settings >> General >> Advanced
        - Shared Clipboard >> Bidirectional
        - Drag'nDrop >> Bidirectional
    - [Copy and pasting between host and VM](https://apple.stackexchange.com/questions/132233/copy-and-pasting-between-host-and-vm)
- Guest VM >> Settings >> Display >> Vedio Memory: 128 MB
- **INSTALL VIRTUALBOX GUEST ADDITIONS**
    - VirtualBox Menu >> Devices >> Insert **Guest Addtions** CD Image... >> Run
    - reboot
- As a MAC user, it's really annoying for having HOST + C as the shortcut for Scaled Mode
    - Disable the shortcut (Host + C)
        - VirtualBox Menu >> Preferences... >> Input >> Virtual Machine >> Scaled Mode (default: Host + C) >> Unset shortcut
- Shared Folder
    - First
        
        > INSTALL THE LATEST GUEST ADDITIONS
        
    - Guest VM >> Settings >> Shared Folders >> Adds new shared folder
        - Folder Path >> Others >> locate the folder in Host
        - Folder Name: (e.g., shared)
            - check Auto-mount
        - Mount Name: (e.g., shared)
    - In Guest OS
        
        ```console
        # Ubuntu Desktop 18.04.2
        wenching@wenching-VirtualBox:~$ groups wenching
        wenching : wenching adm cdrom sudo dip plugdev lpadmin sambashare
        wenching@wenching-VirtualBox$ sudo usermod -aG vboxsf wenching
        wenching@wenching-VirtualBox:~$ groups wenching
        wenching : wenching adm cdrom sudo dip plugdev lpadmin sambashare vboxsf
        
        # CentOS 7
        [wenching@localhost ~]$ groups wenching
        wenching wheel
        [wenching@localhost ~]$ sudo usermod -aG vboxsf wenching
        [wenching@localhost ~]$ groups wenching
        wenching wheel vboxsf
        ```
        
        - [DEPRECATED] Error after **`sudo usermod -a -G vboxsf wenching`**
            
            ```console
            wenching@localhost:~$ sudo usermod -a -G vboxsf wenching
            [sudo] password for wenching: 
            usermod: cannot open /etc/shadow
            wenching@localhost:~$ sudo lsattr /etc/shadow /etc/passwd
            -----a---------- /etc/shadow
            ---------------- /etc/passwd
            wenching@localhost:~$ sudo ls -alh /etc/shadow /etc/passwd
            -rw-r--r--. 1 root root 2.4K May 13 12:52 /etc/passwd
            ----------. 1 root root 1.3K May 13 12:58 /etc/shadow
            ```
            
    - reboot
    - the shared folder (e.g., sf_shared) will be at /media/sf_shared and a shortcut on the desktop
    - **Enable symlinks feature** in VirtualBox
        - e.g., ln: failed to create symbolic link ‘XXX’: Operation not permitted
        
        ```console
        # get all registry keys
        HostOS $ VBoxManage getextradata UbuntuDesktop18.04 enumerate
        # Key: GUI/LastNormalWindowPosition, Value: -2362,45,800,621
        
        # register a key
        HostOS $ VBoxManage setextradata UbuntuDesktop18.04 VBoxInternal2/SharedFoldersEnableSymlinksCreate/shared 1
        
        # unregister a key
        HostOS $ VBoxManage setextradata UbuntuDesktop18.04 VBoxInternal2/SharedFoldersEnableSymlinksCreate/Users/wenching/Desktop/Sync/CRI/VirtualBox/shared # setextradata without a value is to unset/remove/delete the key
        ```
        
        -reboot
- Error Messages
    - To reinstate these messages, go to **VirtualBox VM >> Reset All Warnings**
    - You have **Auto capture keyboard** option turned on.This will cause the Virtual Machine to automatically **capture** the keyboard every time the VM window is activated and make it unavailable to other application running on your host machine: when the keyboard is captured , all keystrokes (including system ones like Alt-Tab) will be directed to the VM.
    - The Virtual Machine reports that the guest OS does not support **mouse pointer integration** in the current video mode.  You need to capture the mouse (by clicking over the VM display or pressing the host key) in order to use the mouse inside the guest OS.
        - [(After Installing Guest Additions,) That message can appear during VM boot, as the GA aren't loaded yet.](https://forums.virtualbox.org/viewtopic.php?f=7&t=41326)



***

## Create a VM

- Name and operating system
    - Name:
    - Machine Folder: `/User/wenching/VirtualBox VMs`
    - Type: `Linux`/Microsoft Windows/Solaris/BSD/IBM OS/2/Mac OS X/Other
    - Version: Ubuntu (64-bit)
- Memory size: `1024+ MB`
- Hard disk: `Create a virtual hard disk now`
- Hard disk file type: **VHD (Virtual Hard Disk)**
- (Optional) Storage on physical hard disk: 
    - `Dynamically allocated`
        - File Location and size: `12GB`
    - Fixed size: e.g., 24GB
- Created Inital State > Setting (Guest VM >> Settings)
    - General >> Advanced
        - Shared Clipboard >> `Bidirectional`
        - Drag'nDrop >> `Bidirectional`
    - Display >> Vedio Memory: `128 MB`
    - STORAGE (Storage >> Controller: IDE >> Empty >> DISK icon) 
        - Choose Virtual Optical Disk File >> X.iso / if loaded, Storage > X.iso
    - Audio: check **OUT** both Enable Audio Output/Input
    - NETWORK > Adapter 1 > `Bridged Adapter` > Name: (e.g., en0: Wi-Fi (AirPort) or en4: Apple USB Ethernet Adapter)
    - Shared Folders >> Adds new shared folder
        - Folder Path >> Others >> locate the folder in Host
        - Folder Name: (e.g., shared)
            - check `Auto-mount`
        - Mount Name: (e.g., `shared`)
- START
    - UbuntuDesktop18.04
        - Install Ubuntu
        - Keyboard layout: Default as English(US)
        - Updates and other software:
            - What apps would you like to install to start with? Default as `Normal installation`
            - Other options: `Download updates while intsalling Ubuntu`
        - Installation type: default to `Erase disk and install Ubuntu`
        - Install
            - Where are you? `Chicago`
            - Who are you?
                - Your name: `wenching`
                    - when typing this field, the two following fields will be automatically generated.
                - Your computer's name: wenching-VirtualBox (The name it uses when it talks to other computers.)
                - Pick a username: wenching
                - Choose a password: **12345**
                - Confirm your password: **12345**
                - Log in automatically / (default) Require my password to log in
        - LOGIN
        - Terminal
            
            ```
            sudo apt-get update && sudo apt-get upgrade
            ```
            
        - **INSTALL VIRTUALBOX GUEST ADDITIONS**
            - [VirtualBox Guest Additions problems](https://askubuntu.com/questions/1035030/virtualbox-guest-additions-installation-problem/1035043)
                
                This system is currently not set up to build kernel modules.  
                Please install the gcc make perl packages from your distribution.  
                VirtualBox Guest Additions: Running kernel modules will not be replaced until the system is restarted.
                
                ```console
                wenching@wenching-VirtualBox:~$ sudo apt-get update && sudo apt-get upgrade && sudo apt-get install build-essential gcc make perl dkms
                # then reboot
                ```
                
            - start a VM >> VirtualBox VM Menu bar >> Devices >> Install Guest Additions CD Image... >> INSTALLATION
        - apt-get
            
            ```console
            wenching@wenching-VirtualBox:~$ sudo apt-get update && sudo apt-get upgrade && sudo apt-get install vim default-jdk
            ```
            
    - CentOS7
        - DATE & TIME: Region: Americas / City: Chicago
        - INSTALLATION DESTINATION: unselect disk -> No disks selected
        - **SOFTWARE SELECTION**
            - GNOME Desktop with GNOME Applications
            - Internet Applications
            - Legacy X Window System Compatibility
            - Office Suite and Productivity
            - Compatibility Libraries
            - Development Tools
            - System Administration Tools
        - BEGIN INSTALLATION
        - Root Password: **12345**
        - User: **wenching / 12345**
        - REBOOT
        - INITIAL SETUP
            - LICENSING
            - **SYSTEM > NETWORK & HOST NAME > Enable**
        - LOGIN
        - Terminal
            - $ **`sudo yum update`**
            - $ **`sudo systemctl poweroff | reboot`**
        - **INSTALL VIRTUALBOX GUEST ADDITIONS**
            - start a VM >> VirtualBox VM Menu bar >> Devices >> Install Guest Additions CD Image... >> INSTALLATION >> reboot
        - Network
            - Applications >> System Tools >> Settings >> Network >> Enable & Settings >> Check **Connect automatically**
        - Display
            - First, **INSTALL VIRTUALBOX GUEST ADDITIONS**
            - Applications >> System Tools >> Settings >> Devices >> Displays


***



## [Git](https://help.ubuntu.com/lts/serverguide/git.html.en)
- Installation
    
    ```console
    $ sudo apt-get update && sudo apt-get upgrade && \
        sudo apt-get install -y \
        git
    $ git --version
    ```
- Configuration
    
    ```console
    $ git config --global user.name "wenching" && \
      git config --global user.email "wenching.chan@gmail.com" && \
      git config --global apply.whitespace nowarn && \
      git config --global color.ui true && \
      git config --list
    ```


***



## Sigularity
- [Install on Linux](https://www.sylabs.io/guides/3.2/user-guide/installation.html)
    - Install Dependencies
        
        ```console
        $ sudo apt-get update && sudo apt-get upgrade && \
          sudo apt-get install -y \
            build-essential \
            libssl-dev \
            uuid-dev \
            libgpgme11-dev \
            squashfs-tools \
            libseccomp-dev \
            wget \
            pkg-config
        ```
        
    - Install [Go](https://golang.org/dl/)
        
        ```console
        $ mkdir -p /home/wenching/Tools/Go && cd /home/wenching/Tools/Go
        $ wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
        $ sudo tar -xzvf go1.12.6.linux-amd64.tar.gz
        $ mv go go1.12.6 && ln -sf go1.12.6 CURRENT
        $ vim ~/.bashrc
          export GOPATH=${HOME}/go
          export PATH=/home/wenching/Tools/Go/CURRENT/bin:${GOPATH}/bin:$PATH
        $ source ~/.bashrc && go version
        ```
        
    - Download from source
        
        ```console
        $ sudo git clone https://github.com/sylabs/singularity.git
        ```
        
    - Compile Singularity
        
        ```console
        $ cd singularity && \
          ./mconfig && \
          make -C ./builddir && \
          sudo make -C ./builddir install
        ```
        ```console
        => project singularity setup with :
            - host arch: x86_64
            - host wordsize: 64-bit
            - host C compiler: cc
            - host Go compiler: /home/wenching/Tools/Go/CURRENT/bin/go
            - host system: unix
              ---
            - target arch: x86_64
            - target wordsize: 64-bit
            - target C compiler: cc
              ---
            - config profile: release
              ---
            - SUID install: yes
            - Network plugins: yes
              ---
            - verbose: no
              ---
            - version: 3.2.0-498.gf91c34935
        => /home/wenching/Tools/singularity/builddir/Makefile ready, try:
            $ cd /home/wenching/Tools/singularity/builddir
            $ make
        make: Entering directory '/home/wenching/Tools/singularity/builddir'
          GO singularity
            [+] GO_TAGS "containers_image_openpgp sylog apparmor selinux seccomp"
        ```
        
    - [Optional] Remove an old version
        
        ```console
        $ for file in `find /usr/local -name '*singularity' -print`; do echo $file; sudo rm -rf $file; done
        ```
    
    - Test
        
        [Download pre-built images](https://www.sylabs.io/guides/3.0/user-guide/quick_start.html#download-pre-built-images)
        ```
        mkdir test; cd test
        singularity build lolcow.sif docker://godlovedc/lolcow
        singularity exec lolcow.sif cowsay moo
        ```
        
        [Singularity Definition Files](https://www.sylabs.io/guides/3.0/user-guide/quick_start.html#singularity-definition-files)
        ```
        $ cd test; cat lolcow.def
        BootStrap: library
        From: ubuntu:16.04
        
        %post
            apt-get -y update
            apt-get -y install fortune cowsay lolcat
        
        %environment
            export LC_ALL=C
            export PATH=/usr/games:$PATH
        
        %runscript
            fortune | cowsay | lolcat
        
        %labels
            Author GodloveD
        
        sudo singularity build lolcow.sif lolcow.def
        ```
        
    - Building containers from Singularity definition files
        
        ```console
        $ ls
        roar.def
        $ cat roar.def
        ```

***



##  Docker Community Edition (CE)

- [Get Docker CE for CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
    - The **centos-extras** repository must be enabled (default).
        - [YUM: List All Configured Repositories](https://www.cyberciti.biz/faq/centos-fedora-redhat-yum-repolist-command-tolist-package-repositories/)
            - $ **`sudo yum update && sudo yum repolist`**
    - Install Docker CE using the repository
        - This is the recommended approach for ease of installation and upgrade tasks.
        - SET UP THE REPOSITORY
            - $ **`sudo yum update && sudo yum install -y yum-utils device-mapper-persistent-data lvm2`**
            - $ **`sudo yum-config-manager --add-repo`** https://download.docker.com/linux/centos/docker-ce.repo
        - INSTALL DOCKER CE
            - list the available versions in the repo, or
                - $ **`sudo yum update && sudo yum list docker-ce --showduplicates | sort -r`**
            - install the latest version of Docker CE and containerd
                - $ **`sudo yum update && sudo yum install docker-ce docker-ce-cli containerd.io`**
                    - 2019-05-13
                        - container-selinux-2.95-2.el7_6.noarch.rpm
                        - docker-ce-**18.09.6**-3.el7.x86_64.rpm
                        - containerd.io-**1.2.5-3.1**.el7.x86_64.rpm
                        - docker-ce-cli-18.09.6-3.el7.x86_64.rpm
                    - If prompted to accept the GPG key, verify that the fingerprint matches **060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35**, and if so, accept it.
            - Start Docker
                - $ **`sudo systemctl start docker`**
            - Check whether docker is on
                - $ **`systemctl show --property ActiveState docker`** # ActiveState=active
            - Verify that Docker CE is installed correctly by running the hello-world image.
                - $ **`sudo docker run hello-world`**
                    - Hello from Docker! This message shows that your installation appears to be working correctly.
- Tips
    - create a user a/c **docker** and add it to existing group **docker**
        - $ **`sudo useradd -g docker docker`**
    - set up password of docker
        - $ **`sudo passwd docker** (e.g., **docker`**)
- Operation
    - $ **`sudo docker info`**
    - delete all images
        - $ **`sudo docker rmi $(docker images -q)`**
    - $ **`sudo docerk container ls -a`**
    - kill all running containers
        - $ **`sudo docker kill $(docker ps -q)`**
    - $ sudo docker ps
    - remove all unused objects and volumns
        - $ **`sudo docker system prune --volumes`**
    - remove one or more containers
        - $ **`sudo docker container rm CONTAINER_ID [CONTAINER_ID]`**
    - see the logs
        - $ **`docker logs CONTAINER_NAME`**


***

## Redmine


### Usinge Docker

- Resources
    - http://blog.51yip.com/cloud/1868.html
    - https://www.cnblogs.com/YatHo/p/7863067.html
    - https://blog.csdn.net/kimqcn4/article/details/79730733

- switch to docker specific a/c
    - $ **`sudo su - docker`**
- images from [sameersbn](https://hub.docker.com/u/sameersbn) @ Docker Hub
    - $ **`docker pull redmine:latest`**
    - $ **`docker pull mysql:latest`**
    - $ **`docker pull sameersbn/redmine`** # docker search redmine # 2nd most downloaded image
    - $ **`docker pull sameersbn/postgresql`** # docker search redmine # 2nd most downloaded image
- create mirror dictionaries
    - $ **`mkdir -p /home/docker/redmine/redmine`**
    - $ **`mkdir -p /home/docker/redmine/postgresql`**
- create Docker containers
    - $ **`docker run --name=mysql-redmine -d --env='MYSQL_ROOT_PASSWORD=password' --env='MYSQL_DATABASE=redmine' --restart=always --volume=/home/docker/redmine/mysql:/var/lib/mysql mysql:latest --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci`**
        - **--character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci**: to change the default encoding and collation for all tables to use UTF-8 (utf8mb4)
        - (optional) --publish=23306:3306: if host OS already has a MySQL at 3306
        - $ **`docker exec -it mysql-redmine bash -l`**
    - $ **`docker run --name=postgresql-redmine -d --env='DB_NAME=redmine_production' --env='DB_USER=redmine' --env='DB_PASS=password' --restart=always --volume=/home/docker/redmine/postgresql:/var/lib/postgresql sameersbn/postgresql`**
        - Error: docker: Error response from daemon: failed to start shim: exec: "containerd-shim": executable file not found in $PATH: unknown.
        - $ **`docker exec -it postgresql-redmine sudo -u postgres psql`**
        - postgres=# **\list**
            
            | Name | Owner | Encoding | Collate | Ctype | Access privileges |
            | --- | --- | --- | --- | --- | --- |
            | redmine_production | postgres | UTF8 | C | C | =Tc/postgres         + |
            |  |  |  |  |  | postgres=CTc/postgres+ |
            |  |  |  |  |  | redmine=CTc/postgres   |
            
    - $ **`docker run --name=redmine -d --link=postgresql-redmine:postgresql --publish=10083:80 --env='REDMINE_PORT=10083' --restart=always --volume=/home/docker/redmine/redmine:/home/redmine/data sameersbn/redmine`**


***
