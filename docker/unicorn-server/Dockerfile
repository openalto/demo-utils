FROM opendaylight/odl:5.4.0
LABEL maintainer "Jensen Zhang <hack@jensen-zhang.site>"

# Install Dependencies
RUN yum -y --setopt=tsflags=nodocs update \
    && yum -y --setopt=tsflags=nodocs install git python34-devel python34-setuptools python34-pip \
        python-devel python-setuptools python2-pip java-1.8.0-openjdk-devel \
    && echo 'Downloading maven...' \
    && curl -sSLO http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    && echo 'Done' \
    && tar -zxf apache-maven-3.3.9-bin.tar.gz -C /opt \
    && ln -s /opt/apache-maven-3.3.9/bin/mvn /usr/bin/mvn \
    && mkdir -p /root/.m2 \
    && curl -sSL https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > /root/.m2/settings.xml \
    && git clone https://github.com/openalto/alto-experimental -b odl-boron-sr4 \
    && pushd alto-experimental \
    && mvn clean install -Ptest -DskipTests \
    && unzip alto-bwmonitor/features/target/alto-bwmonitor-*.kar 'repository/*' \
    && unzip alto-pathmanager/features/target/alto-pathmanager-*.kar 'repository/*' \
    && unzip alto-unicorn/features/target/alto-unicorn-*.kar 'repository/*' \
    && cp -r repository/* /opt/opendaylight/system/ \
    && chown -R odl:odl /opt/opendaylight/system/ \
    && popd \
    && git clone https://github.com/openalto/alto-nova \
    && pushd alto-nova \
    && pip3 install -r requirements.txt \
    && python3 setup.py install \
    && popd \
    && git clone https://github.com/openalto/alto-domain-agent \
    && pushd alto-domain-agent \
    && mvn clean package \
    && cp target/unicorn-server.war /opt/ \
    && cp -r target/unicorn-server /opt/ \
    && cp bin/pyunicorn /usr/bin/ \
    && popd \
    && pip2 install python-odl \
    && curl -sSL -o /opt/jetty-runner.jar http://central.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.7.v20170914/jetty-runner-9.4.7.v20170914.jar \
    && yum clean all && rm -rf /tmp/* /var/tmp/* /root/.m2/repository/*

COPY patch/instance.py /usr/lib/python2.7/site-packages/odl/instance.py
COPY patch/templates /var/lib/data/python-odl/templates

COPY docker-entry-point /docker-entry-point
RUN chmod 755 /docker-entry-point

EXPOSE 80
EXPOSE 6633

ENTRYPOINT [ "/docker-entry-point" ]
