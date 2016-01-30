FROM jboss/keycloak-mysql:1.8.0.Final

ADD standalone.xml /opt/jboss/keycloak/standalone/configuration/
ADD keycloak.jks /etc/secret-volume/

EXPOSE 8443
