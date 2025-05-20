#!/bin/bash

# exit on error
set -euo pipefail

# Ensure script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Parse arguments
CONTAINER=""
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -d|--domain) DOMAIN="$2"; shift ;;
    -t|--target_location) TARGET_LOCATION="$2"; shift ;;
    -c|--container) CONTAINER="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

if [[ -z "$DOMAIN" || -z "$TARGET_LOCATION" ]]; then
  echo "Usage: $0 -d <domain> -t <target_location> [-c <container_name>]"
  exit 1
fi

echo "Renewing certificate for $DOMAIN"
export TARGET_LOCATION

# Load onepassword environment variables
export $(grep -v '^[[:space:]]*#' env | xargs)

# Pull op v2 
docker pull 1password/op:2

# Retrieve and store the AWS Access Keys from 1Password
AWS_ACCESS_KEY_ID=$(docker run --rm --name op \
-e OP_CONNECT_HOST=$OP_CONNECT \
-e OP_CONNECT_TOKEN=$OP_API_TOKEN \
1password/op:2 op read op://$OP_VAULT_ID/Certbot\ IAM\ Access\ Key\ and\ Secret/accessKeyId)

AWS_SECRET_ACCESS_KEY=$(docker run --rm --name op \
-e OP_CONNECT_HOST=$OP_CONNECT \
-e OP_CONNECT_TOKEN=$OP_API_TOKEN \
1password/op:2 op read op://$OP_VAULT_ID/Certbot\ IAM\ Access\ Key\ and\ Secret/accessSecret)

# Now, remove the old concatenated certificates, renew the certificate, and replace with the new concatenated certificates
CERT_PATH="$TARGET_LOCATION"
cd $CERT_PATH
rm -f "$DOMAIN.pem"

docker pull certbot/dns-route53:v4.0.0

CERTBOT_OUTPUT=$(docker run --rm --name certbot \
-e AWS_ACCESS_KEY_ID=$(echo $AWS_ACCESS_KEY_ID | tr -d '\r' ) \
-e AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY | tr -d '\r' ) \
-v "/etc/letsencrypt:/etc/letsencrypt" \
-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
certbot/dns-route53 certonly -n --agree-tos --dns-route53 -d $DOMAIN 2>&1)

echo "$CERTBOT_OUTPUT"

if echo "$CERTBOT_OUTPUT" | grep -q "Certificate not yet due for renewal; no action taken."; then
  echo "Certificate not yet due for renewal; exiting script."
  # exit 1 here so we can queue this up with && docker compose restart ... after it
  exit 1
fi

echo "Certificate renewed successfully, concatenating to $TARGET_LOCATION/$DOMAIN.pem"

cat /etc/letsencrypt/live/$DOMAIN/cert.pem > $TARGET_LOCATION/$DOMAIN.pem

cat /etc/letsencrypt/live/$DOMAIN/privkey.pem >> $TARGET_LOCATION/$DOMAIN.pem

chmod a+r $TARGET_LOCATION/$DOMAIN.pem

if [[ -n "$CONTAINER" ]]; then
  echo "Restarting Docker container: $CONTAINER"
  docker restart "$CONTAINER"
fi