WORK_HOME=$HOME

# Stop opendaylight
#$WORK_HOME/opendaylight/bin/stop
sudo kill $(ps aux | grep karaf | awk '{print $2}')

# Stop mininet
sudo kill $(ps aux | grep xdom-mn | awk '{print $2}')
sudo mn -c

# Stop domain-agent
sudo kill $(ps aux | grep jetty | awk '{print $2}')

# Stop UnicornUI and orchestrator
sudo kill $(ps aux | grep gunicorn | awk '{print $2}')
