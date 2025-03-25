#!/bin/bash
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz
tar -xvzf apache-tomcat-9.0.80.tar.gz
mv apache-tomcat-9.0.80 tomcat
cp target/*.war tomcat/webapps/
chmod +x tomcat/bin/catalina.sh
./tomcat/bin/catalina.sh run
