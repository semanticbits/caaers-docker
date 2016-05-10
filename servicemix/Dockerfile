FROM        caaers:java

MAINTAINER  Biju Joseph

ENV SERVICEMIX_HOME /usr/local/servicemix	
ENV SERVICEMIX_ARCHIVE apache-servicemix-3.4.1
ENV SERVICEMIX_TGZ_URL http://archive.apache.org/dist/servicemix/servicemix-3/3.4.1/$SERVICEMIX_ARCHIVE.tar.gz

# SET THE WORKING DIR
RUN mkdir -p $SERVICEMIX_HOME
WORKDIR $SERVICEMIX_HOME

RUN mkdir -p /tmp/caaers
RUN wget $SERVICEMIX_TGZ_URL -P /tmp/caaers/
RUN ls /tmp/caaers/
RUN tar -xvf /tmp/caaers/apache-servicemix-3.4.1.tar.gz -C /tmp/caaers/ ; exit 0
RUN cp -R /tmp/caaers/$SERVICEMIX_ARCHIVE/* $SERVICEMIX_HOME/


RUN rm -rf /tmp/caaers
ADD https://github.com/colorshifter/caaers-dist/blob/release/2.8-RC2/caaers-adeers-sync-sa-2.8-RC2.zip?raw=true $SERVICEMIX_HOME/hotdeploy/

RUN rm -rf $SERVICEMIX_HOME/data
COPY lookup.xml $SERVICEMIX_HOME/
COPY caxchange.properties $SERVICEMIX_HOME/conf
COPY sm-entrypoint.sh $SERVICEMIX_HOME/bin/sm-entrypoint.sh

RUN mv $SERVICEMIX_HOME/conf $SERVICEMIX_HOME/conf_original
RUN mkdir -p $SERVICEMIX_HOME/conf
RUN rm -rf $SERVICEMIX_HOME/data
RUN mkdir -p $SERVICEMIX_HOME/data

ENV PATH $SERVICEMIX_HOME/bin:$PATH
RUN chmod +x $SERVICEMIX_HOME/bin/*

VOLUME ["/usr/local/servicemix/data", "/usr/local/servicemix/"]
RUN echo "============================= ENV =================================="
RUN env
RUN echo "===================================================================="

EXPOSE 8196 7700 6611 61616


ENTRYPOINT ["sm-entrypoint.sh"]
CMD ["servicemix"]

