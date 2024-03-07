#!/bin/bash

set -e
set -o pipefail

apt-get update

# docker
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    lsof \
    jq


curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
docker -v

# java
apt install -y openjdk-11-jdk
java -version

# dcm4che
wget https://www.dcm4che.org/maven2/org/dcm4che/dcm4che-assembly/5.31.2/dcm4che-assembly-5.31.2-bin.tar.gz
tar xzvf dcm4che-assembly-5.31.2-bin.tar.gz -C /opt
mv /opt/dcm4che-5.31.2 /opt/dcm4che
echo DEBUG Showing dcm4che assembly
export PATH=/opt/dcm4che/bin:$PATH

# maven
wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar xzvf apache-maven-3.6.3-bin.tar.gz -C /opt
export PATH=/opt/apache-maven-3.6.3/bin:$PATH
mvn -v

# gradle
wget https://services.gradle.org/distributions/gradle-6.9-bin.zip
mkdir /opt/gradle
unzip -d /opt/gradle gradle-6.9-bin.zip
ls /opt/gradle/gradle-6.9
export PATH=$PATH:/opt/gradle/gradle-6.9/bin
gradle -v

# netstat
apt install net-tools


