# on machine do 
# chmod +x keycloak/entrypoint.sh
FROM alpine:3.19 as generator

RUN apk add --no-cache gettext

WORKDIR /app
COPY keycloak/realm-config/myrealm-realm.json.template .
COPY keycloak/generate-realm.sh .

ARG KEYCLOAK_REALM
ARG KEYCLOAK_CLIENT_ID
ARG KEYCLOAK_REDIRECT_URI

ENV KEYCLOAK_REALM=${KEYCLOAK_REALM}
ENV KEYCLOAK_CLIENT_ID=${KEYCLOAK_CLIENT_ID}
ENV KEYCLOAK_REDIRECT_URI=${KEYCLOAK_REDIRECT_URI}

RUN chmod +x generate-realm.sh && \
    ./generate-realm.sh

FROM quay.io/keycloak/keycloak:24.0.3

COPY --from=generator /app/myrealm-realm.json /opt/keycloak/data/import/myrealm-realm.json

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]
