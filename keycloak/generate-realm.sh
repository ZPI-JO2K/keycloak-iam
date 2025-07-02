#!/bin/sh
set -e
echo "Generating realm JSON..."
envsubst < myrealm-realm.json.template > myrealm-realm.json
cat myrealm-realm.json
