import mininet.node
import mininet.link

from mininet.link import TCLink
from mininet.cli import CLI
from mininet.node import RemoteController
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.log import setLogLevel


class IntroTopo(Topo):

    def build(self):
        sw1 = self.addSwitch("sw1")
        sw2 = self.addSwitch("sw2")
        sw3 = self.addSwitch("sw3")
        sw4 = self.addSwitch("sw4")
        sw5 = self.addSwitch("sw5")
        sw6 = self.addSwitch("sw6")
        sw7 = self.addSwitch("sw7")
        sw8 = self.addSwitch("sw8")

        s1 = self.addHost("s1")
        s2 = self.addHost("s2")
        d1 = self.addHost("d1")
        d2 = self.addHost("d2")

        self.addLink(s1, sw1, bw=100)
        self.addLink(s2, sw2, bw=100)
        self.addLink(sw1, sw5, bw=100)
        self.addLink(sw2, sw5, bw=100)
        self.addLink(sw5, sw6, bw=100)
        self.addLink(sw5, sw7, bw=100)
        self.addLink(sw6, sw8, bw=100)
        self.addLink(sw7, sw8, bw=100)
        self.addLink(sw8, sw3, bw=100)
        self.addLink(sw8, sw4, bw=100)
        self.addLink(sw3, d1, bw=100)
        self.addLink(sw4, d2, bw=100)


def main():
    topo = IntroTopo()
    net = Mininet(topo=topo, controller=None, link=TCLink)
    net.addController('c0', controller=RemoteController, ip='127.0.0.1', port=6633)
    net.start()
    CLI(net)
    net.stop()


if __name__ == '__main__':
    setLogLevel('info')
    main()
