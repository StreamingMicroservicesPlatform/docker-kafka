FROM jboss/keycloak-mysql:latest

ADD standalone.xml /opt/jboss/keycloak/standalone/configuration/
ADD keycloak.jks /etc/secret-volume/

EXPOSE 8443
