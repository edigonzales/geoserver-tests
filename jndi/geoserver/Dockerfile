FROM edigonzales/geoserver-base:2.21.2

LABEL maintainer="Amt fuer Geoinformation Kanton Solothurn"

RUN rm $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/postgresql-42.4.1.jar
COPY postgresql-42.4.1.jar $CATALINA_HOME/lib/postgresql-42.4.1.jar
COPY context.xml $CATALINA_HOME/conf/context.xml