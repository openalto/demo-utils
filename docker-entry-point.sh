#!/bin/sh

echo 'Configuring features repositories and boot...'
sed -i 's_^\(featuresRepositories *=.*\)$_\1,mvn:org.opendaylight.alto.ext/alto-bwmonitor-features/0.1.0.Boron-SR4-SNAPSHOT/xml/features,mvn:org.opendaylight.alto.ext/alto-pathmanager-features/0.1.0.Boron-SR4-SNAPSHOT/xml/features,mvn:org.opendaylight.alto.ext/alto-unicorn-features/0.1.0.Boron-SR4-SNAPSHOT/xml/features_' /opt/opendaylight/etc/org.apache.karaf.features.cfg
sed -i 's_^\(featuresBoot *=.*\)$_\1,odl-l2switch-switch,odl-alto-unicorn-rest_' /opt/opendaylight/etc/org.apache.karaf.features.cfg
#sed -i 's_^\(featuresBoot *=.*\)$_\1,odl-openflowplugin-flow-services-rest_' /opt/opendaylight/etc/org.apache.karaf.features.cfg

echo 'Starting OpenDaylight...'
/opt/opendaylight/bin/start

echo 'Waiting for controller ready'
sleep 60

echo 'Starting unicorn-server'
java -jar /opt/jetty-runner.jar --port 80 --log /var/log/jetty.log /opt/unicorn-server
