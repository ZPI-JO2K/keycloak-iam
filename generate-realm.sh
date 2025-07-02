#!/bin/bash
set -e
echo "Generating Keycloak realm JSON from environment variables..."
envsubst < keycloak/realm-config/myrealm-realm.json.template > keycloak/realm-config/myrealm-realm.json
echo "Done. Generated file:"
cat keycloak/realm-config/myrealm-realm.json
