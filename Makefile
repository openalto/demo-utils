SHELL := /bin/bash

docker-install:
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${shell lsb_release -cs} stable"
	sudo apt update
	sudo apt install docker-ce
	sudo usermod -a -G docker ${shell whoami}

docker-prepare: docker-install
	sudo docker pull fno2010/unicorn-server:odl-boron-sr4

virtualenv-install:
	sudo pip install virtualenvwrapper

virtualenv-prepare: virtualenv-install
	echo 'export WORKON_HOME=$$HOME/.envs' >> ~/.bashrc
	echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
	export WORKON_HOME=${HOME}/.envs && \
	mkdir -p ${HOME}/.envs && \
	source /usr/local/bin/virtualenvwrapper.sh && \
	mkvirtualenv unicorn

misc-install:
	sudo apt install pv bc jq

misc-prepare: misc-install
	sudo -u root mkdir -p /root/.ssh
	sudo -u root bash -c "cat /root/.ssh/id_rsa.pub || ssh-keygen"
	sudo -u root bash -c "cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys"

prepare: docker-prepare virtualenv-prepare misc-prepare

start-case2-step1:
	utils/start-step1.sh

start-case2-step2:
	utils/start-step2.sh

stop-case2:
	utils/stop-all.sh

ec2-case1-start:
	ec2-utils/start-step1.sh case1

ec2-case1-config:
	ec2-utils/start-step2.sh case1

ec2-case2-start:
	ec2-utils/start-step1.sh case2

ec2-case2-config:
	ec2-utils/start-step2.sh case2

ec2-case3-start:
	ec2-utils/start-step1.sh case3

ec2-case3-config:
	ec2-utils/start-step2.sh case3

ec2-case4-start:
	ec2-utils/start-step1.sh case4

ec2-case4-config:
	ec2-utils/start-step2.sh case4

ec2-stop:
	ec2-utils/stop-all.sh

