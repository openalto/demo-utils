SHELL := /bin/bash

docker-install:
	sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${shell lsb_release -cs} stable"
	sudo apt update
	sudo apt install -y docker-ce
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
	mkvirtualenv -p python2 unicorn

misc-install:
	sudo apt update
	sudo apt install -y pv bc jq python-pip

mn-install:
	git clone https://github.com/mininet/mininet ~/mininet && \
	pushd ~/mininet && ./util/install.sh && popd; \
	git clone https://github.com/openalto/xdom-mn ~/xdom-mn && \
	pushd ~/xdom-mn && sudo python setup.py install && popd; \

misc-prepare: misc-install mn-install
	#sudo -u root mkdir -p /root/.ssh
	#sudo -u root bash -c "cat /root/.ssh/id_rsa.pub || ssh-keygen"
	#sudo -u root bash -c "cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys"
	mkdir -p ~/.ssh
	cat ~/.ssh/id_rsa.pub || ssh-keygen
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	git clone https://github.com/openalto/alto-orchestrator ~/alto-orchestrator --branch afm2018-case3
	git clone https://github.com/openalto/UnicornUI ~/UnicornUI

prepare: misc-prepare docker-prepare virtualenv-prepare

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

