#!/bin/bash

# exit on error
set -euo pipefail
IFS=$'\n\t'

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -d|--domain) DOMAIN="$2"; shift ;;
    -t|--target_location) TARGET_LOCATION="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

if [[ -z "$DOMAIN" || -z "$TARGET_LOCATION" ]]; then
  echo "Usage: $0 -d <domain> -t <target_location>"
  exit 1
fi

echo "Renewing certificate for $DOMAIN"
export TARGET_LOCATION

# # Load onepassword environment variables
source .env

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
rm $DOMAIN.pem

docker pull certbot/dns-route53:v4.0.0

docker run --rm --name certbot \
-e AWS_ACCESS_KEY_ID=$(echo $AWS_ACCESS_KEY_ID | tr -d '\r' ) \
-e AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY | tr -d '\r' ) \
-v "/etc/letsencrypt:/etc/letsencrypt" \
-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
certbot/dns-route53 certonly -n --dns-route53 -d $DOMAIN

cat /etc/letsencrypt/live/$DOMAIN/cert.pem > $TARGET_LOCATION/$DOMAIN.pem

cat /etc/letsencrypt/live/$DOMAIN/privkey.pem >> $TARGET_LOCATION/$DOMAIN.pem

chmod a+r $TARGET_LOCATION/$DOMAIN.pem