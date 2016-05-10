FROM        caaers:ubuntu

MAINTAINER  Biju Joseph

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle	

# INSTALL JAVA 8
RUN         echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
            echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
            add-apt-repository -y ppa:webupd8team/java && \
            apt-get update && \
            apt-get install -y oracle-java8-installer && \
			rm -rf /var/cache/oracle-jdk8-installer
				
RUN echo 'JAVA HOME file listing:' 		
RUN ls /usr/lib/jvm/java-8-oracle

