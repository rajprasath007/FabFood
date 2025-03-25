# Use official Tomcat + JDK image
FROM tomcat:10.1-jdk17-openjdk-slim

# Copy your .war file into Tomcat's webapps directory
COPY Fabfood-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# (Optional) If you have external configs (e.g., JNDI, properties)
# COPY config/* /usr/local/tomcat/conf/

# Expose port 8080 (Tomcat default)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]