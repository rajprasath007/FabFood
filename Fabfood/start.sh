#!/bin/bash
# Install Java (if not available)
apt-get update && apt-get install -y openjdk-11-jdk

# Start Tomcat and deploy your .war file
export CATALINA_HOME=/usr/local/tomcat
export PATH=$CATALINA_HOME/bin:$PATH
catalina.sh run
