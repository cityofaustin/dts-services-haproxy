# Certbot Certificate Renewal Script

This folder contains a script to automate the renewal of Let's Encrypt SSL/TLS certificates for specific subdomains managed by the DTS Services HAProxy infrastructure. The script is designed to work with AWS Route53 DNS validation and retrieves credentials securely from 1Password.

## Currently Supported Host Names

This script is currently used for the following subdomains, but is not limited to these domains. Any DNS entry hosted in the DTS Route 53 zones may have certificates generated or renewed using this script.

- **atd-postgrest.austinmobility.io**
- **equitytool.austinmobility.io**

## Usage

```bash
sudo ./renew_ssl_tls_certbot_certificate.sh -d <domain> [-t <target_location>] [-c <container_name>]
```

- `-d, --domain` (required): The fully qualified domain name (FQDN) to renew.
- `-t, --target_location` (optional): Directory where the concatenated PEM file will be written.
- `-c, --container` (optional): Docker container name to restart after renewal.

## Example Production Invocations

### atd-postgrest.austinmobility.io

```bash
sudo ./renew_ssl_tls_certbot_certificate.sh \
  -d atd-postgrest.austinmobility.io \
  -t /srv/dts-services-haproxy/ssl \
  -c haproxy
```

### equitytool.austinmobility.io

```bash
sudo ./renew_ssl_tls_certbot_certificate.sh \
  -d equitytool.austinmobility.io \
  -t /srv/dts-services-haproxy/ssl \
  -c haproxy
```

## Environment Setup

1. Copy `env-template` to `env` and fill in the required 1Password related values.
2. Run the script as root, so it can access certificates in `/etc/letsencrypt/`.

## Notes

- Certificates are stored in `/etc/letsencrypt/live/<domain>/` by default.
- The concatenated PEM file will be written to the specified `target_location` as `<domain>.pem`.
- The script will only restart the specified Docker container if the `-c` argument is provided.
- The script will exit if the certificate is not yet due for renewal.
