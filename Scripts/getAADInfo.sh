#!/bin/bash

account=$(az account show -o json);
tenantId=$(echo "$account" | jq -r '.tenantId');
upn=$(echo "$account" | jq -r '.user.name');
adUser=$(az ad user show --id "$upn" -o json);
objectId=$(echo "$adUser" | jq -r '.id');

jq -n --arg objectId "$objectId" --arg tenantId "$tenantId" '{objectId:$objectId,tenantId:$tenant}'> "$AZ_SCRIPTS_OUTPUT_PATH";
