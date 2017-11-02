# Some Utility Scripts for Demo Setup

## Install Dependencies

``` bash
pip install -r requirements.txt
```

## Flow Management

Download all the scripts into the same directory and run the following command on the controller host:

``` bash
# Remove all flows
./check-flow.sh --filter '' | ./remove-flow.sh

# Remove all flows which name starting with '#UF' (which should be undefined flows)
./check-flow.sh --filter '#UF' | ./remove-flow.sh
```

If scripts are not on the controller host, you should pass the IP address of the controller host from the command-line argument:

``` bash
CONTROLLER_IP=10.0.0.100 # For example
./check-flow.sh --filter '#UF' $CONTROLLER_IP | ./remove-flow.sh $CONTROLLER_IP
```

## Execute Remote Command

> **NOTE:** Python 2 Only!

Allow you to execute some command remotely via ssh interactive mode.

``` bash
./execute_remote.py -c 1.1.1.1 'echo ${karaf.home}'
```

Check the detailed usage:

```
usage: execute_remote.py [-h] [-c CONTROLLER] [-p PORT] [-l LOGIN]
                         [-P PASSWORD]
                         [command]

Execute remote command via ssh.

positional arguments:
  command

optional arguments:
  -h, --help            show this help message and exit
  -c CONTROLLER, --controller CONTROLLER
                        IP address of SDN controller.
  -p PORT, --port PORT  SSH port of the SDN controller.
  -l LOGIN, --login LOGIN
                        SSH login name of the SDN controller.
  -P PASSWORD, --password PASSWORD
                        SSH password of the SDN controller.
```
