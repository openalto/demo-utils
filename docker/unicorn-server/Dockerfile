FROM opendaylight/odl:5.4.0
LABEL maintainer "Jensen Zhang <hack@jensen-zhang.site>"

# Install Dependencies
RUN yum -y --setopt=tsflags=nodocs update \
    && yum -y --setopt=tsflags=nodocs install epel-release \
    && yum -y --setopt=tsflags=nodocs install curl git zip unzip \
    && curl -LO -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/jdk-8u151-linux-x64.tar.gz \
    && mkdir /opt/jdk \
    && tar -zxf jdk-8u151-linux-x64.tar.gz -C /opt/jdk \
    && update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_151/bin/java 100 \
    && update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_151/bin/javac 100 \
    && curl -LO http://mirror.cc.columbia.edu/pub/software/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    && tar -zxf apache-maven-3.3.9-bin.tar.gz -C /opt \
    && ln -s /opt/apache-maven-3.3.9/bin/mvn /usr/bin/mvn \
    && mkdir -p /root/.m2 \
    && curl -L https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > /root/.m2/settings.xml \
    && git clone https://github.com/openalto/alto-experimental -b odl-boron-sr4 \
    && cd alto-experimental \
    && mvn clean install -Ptest -DskipTests \
    && unzip alto-bwmonitor/features/target/alto-bwmonitor-*.kar repository/* \
    && unzip alto-pathmanager/features/target/alto-pathmanager-*.kar repository/* \
    && unzip alto-unicorn/features/target/alto-unicorn-*.kar repository/* \
    && cp -r repository/* /opt/opendaylight/system/ \
    && cd .. \
    && git clone https://github.com/openalto/alto-domain-agent \
    && cd alto-domain-agent \
    && mvn clean package \
    && cp target/unicorn-server.war /opt/ \
    && curl -L -o /opt/jetty-runner.jar http://central.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.7.v20170914/jetty-runner-9.4.7.v20170914.jar \
    && yum clean all && rm -rf /tmp/* /var/tmp/*

COPY docker-entry-point /docker-entry-point
RUN chmod 755 /docker-entry-point

EXPOSE 80
EXPOSE 6633

ENTRYPOINT [ "/docker-entry-point" ]