# Docker-based All-in-One Mercator Demo Setup

| Component | Codebase |
|:----------|:---------|
| Mercator Domain Server | <https://github.com/openalto/alto-domain-agent> |
| Mercator Orchestrator | <https://github.com/openalto/alto-orchestrator> |
| Nova Resource State Abstraction Engine | <https://github.com/openalto/alto-nova> |

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

## Reference

If you use Mercator, please cite the [journal paper](https://ieeexplore.ieee.org/document/8756056) with the following BibTex entry:

```
Xiang, Qiao, Jingxuan Jensen Zhang, Xin Tony Wang, Yang Jace Liu, Chin Guok, Franck Le, John MacAuley, Harvey Newman, and Y. Richard Yang.
Toward Fine-Grained, Privacy-Preserving, Efficient Multi-Domain Network Resource Discovery.
IEEE Journal on Selected Areas in Communications 37, no. 8 (2019): 1924-1940.

@article{Mercator_JSAC19,
 author = {Q. Xiang and J. J. Zhang and X. T. Wang and Y. J. Liu and C. Guok and F. Le and J. MacAuley and H. Newman and Y. R. Yang},
 doi = {10.1109/JSAC.2019.2927073},
 issn = {1558-0008},
 journal = {IEEE Journal on Selected Areas in Communications},
 month = {Aug},
 number = {8},
 pages = {1924-1940},
 title = {Toward Fine-Grained, Privacy-Preserving, Efficient Multi-Domain Network Resource Discovery},
 volume = {37},
 year = {2019}
}
```
