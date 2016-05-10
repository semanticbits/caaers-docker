FROM        caaers:java

MAINTAINER  Biju Joseph

ENV CATALINA_HOME /usr/local/tomcat	
ENV CATALINA_CONF $CATALINA_HOME/conf
ENV CAAERS_RULES_REPO /usr/local/caaers/rules-repo
ENV CAAERS_CONF $CATALINA_CONF/caaers

ENV TOMCAT_MAJOR 7
ENV TOMCAT_VERSION 7.0.69
ENV TOMCAT_ARCHIVE apache-tomcat-$TOMCAT_VERSION.zip
ENV TOMCAT_ARCHIVE_FOLDER apache-tomcat-$TOMCAT_VERSION
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/$TOMCAT_ARCHIVE



# SET THE WORKING DIR
RUN mkdir -p $CATALINA_HOME
WORKDIR $CATALINA_HOME
				
# INSTALL TOMCAT
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p /tmp/caaers

RUN wget $TOMCAT_TGZ_URL -P /tmp/caaers/ && \
    unzip /tmp/caaers/$TOMCAT_ARCHIVE -d /tmp/caaers/ && \
    cp -R /tmp/caaers/$TOMCAT_ARCHIVE_FOLDER/* $CATALINA_HOME/ && \
    rm -rf $CATALINA_HOME/logs && \
    rm -rf $CATALINA_HOME/webapps && \
    mkdir -p $CATALINA_HOME/webapps && \
    mkdir -p /usr/local/caaers
	

# Download caaers WAR from Github
ADD https://github.com/colorshifter/caaers-dist/blob/release/2.8-RC2/caaers.zip?raw=true /tmp/caaers
ADD https://github.com/colorshifter/caaers-dist/blob/release/2.8-RC2/caaers.z01?raw=true /tmp/caaers
ADD https://github.com/colorshifter/caaers-dist/blob/release/2.8-RC2/caaers.z02?raw=true /tmp/caaers

# Unzip caaers.war
RUN cat /tmp/caaers/caaers.z01 > /tmp/caaers/caaers_full.zip
RUN cat /tmp/caaers/caaers.z02 >> /tmp/caaers/caaers_full.zip
RUN cat /tmp/caaers/caaers.zip >> /tmp/caaers/caaers_full.zip
RUN unzip /tmp/caaers/caaers_full.zip -d /tmp/caaers/ ; exit 0
		
RUN  cp /tmp/caaers/caaers.war $CATALINA_HOME/webapps/
RUN	 rm -rf /tmp/caaers

# replace and copy configuration files. 
RUN mkdir -p $CAAERS_RULES_REPO
RUN mkdir -p $CAAERS_CONF
COPY server.xml $CATALINA_CONF
COPY catalina.properties $CATALINA_CONF
COPY caaers-ui-lookup.xml $CAAERS_CONF
COPY datasource.properties $CAAERS_CONF
COPY csm_jaas.config $CAAERS_CONF
COPY tomcat-entrypoint.sh $CATALINA_HOME/bin

RUN mv $CATALINA_CONF $CATALINA_HOME/conf_original
RUN mkdir -p $CATALINA_CONF


# make tomcat sh files executable
RUN chmod +x $CATALINA_HOME/bin/*.sh
		
RUN echo "============================= ENV =================================="
RUN env
RUN echo "===================================================================="


VOLUME ["/usr/local/tomcat/conf"]

EXPOSE 8080
ENTRYPOINT ["tomcat-entrypoint.sh"]
CMD ["catalina.sh", "run"]

