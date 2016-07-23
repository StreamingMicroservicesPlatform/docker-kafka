FROM jboss/keycloak-ha-postgres:1.9.8.Final

ADD standalone-ha.xml /opt/jboss/keycloak/standalone/configuration/
ADD keycloak.jks /etc/secret-volume/

EXPOSE 8443
EXPOSE 8480
