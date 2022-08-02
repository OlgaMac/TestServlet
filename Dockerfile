FROM tomcat:9.0
ENV DB_HOST 192.168.3.29
ENV DB_USER tomcat
ENV DB_PASSWORD s3cret
EXPOSE 8085
RUN rm -fr /usr/local/tomcat/webapps/TestServlet
COPY target/webapp /usr/local/tomcat/webapps/TestServlet.war
