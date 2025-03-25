#!/bin/bash
apt-get update && apt-get install -y openjdk-17-jdk tomcat9
cp target/*.war /var/lib/tomcat9/webapps/app.war
systemctl start tomcat9 && tail -f /var/log/tomcat9/catalina.out