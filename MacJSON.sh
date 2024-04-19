#!/bin/bash

# MacJSON, a JSON parser without dependencies.
# (Code named JSONVoorhees, created when downloading jq was problematic)

# Uses mostly code from Matthew Warren @haircut, under MIT license.
# (Thank you, my friend!)
# https://macblog.org/parse-json-command-line-mac/

secretID="AWS-Secrets-Manager-Secret"
jsonAttribute="myPassword"
currentRegion="us-east-1" # Sample

function jsonParse() (
JSONVar="${1}"
INCOMINGDATA="${2}"
JSONReturn=$(osascript -l 'JavaScript' <<< "function run() { var jsoninfo = JSON.parse(\`$INCOMINGDATA\`) ; return jsoninfo.$JSONVar;}")
echo "${JSONReturn}"
)

secretIn=$(aws secretsmanager get-secret-value --region $currentRegion --secret-id "$secretID" --query SecretString --output text)

myPass=$(jsonParse "$jsonAttribute" "$secretIn")

echo "$myPass" is the password.
