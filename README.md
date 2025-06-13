# DTS Services HAProxy

This repository contains the configuration and setup for an HAProxy service used to manage traffic for various applications and services. The HAProxy instance is configured to handle HTTP, HTTPS, and PostgreSQL traffic.

## Repository Structure

- `docker-compose.yaml`: Defines the Docker Compose configuration for running the HAProxy container.
- `haproxy.cfg`: The main configuration file for HAProxy, defining frontends, backends, and ACLs.
- `env-template`: Environment variables template file, containing sensitive information like the database server address. This file is ignored by `.gitignore`.
- `ssl/`: Directory for SSL certificates and keys. Contains a `README.md` with instructions for adding `.pem` files.
  - `equitytool.austinmobility.io.pem`: Example SSL certificate and key file.
- `.dockerignore`: Specifies files and directories to exclude from Docker builds. This file is a symlink of `.gitignore`.
- `.gitignore`: Specifies files and directories to exclude from version control.

## Prerequisites

- Docker and Docker Compose installed on your system.
- SSL certificates in `.pem` format placed in the `ssl/` directory.
- A valid `env` file with the required environment variable.

## Usage

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd dts-services-haproxy
   ```

2. Add your SSL certificates to the `ssl/` directory. Ensure they are named as `<fully qualified domain name>.pem`.

3. Create an `env` file in the root directory with the following content:

   ```env
   DATABASE_SERVER=<your-database-server>
   OP_API_TOKEN=<your-1password-api-token>
   OP_CONNECT=https://coa.1password.austinmobility.io
   OP_VAULT_ID=<your-1password-vault-id>
   ```

4. Start the HAProxy service using Docker Compose:

   ```bash
   docker compose up -d
   ```

5. Watch the logs if needed:
   ```bash
   docker compose logs -f
   ```

## Configuration

- **HAProxy Configuration**: Modify `haproxy.cfg` to update frontends, backends, and ACLs as needed.
- **Environment Variables**: Update the `env` file to point to the correct database server and provide 1Password details.
- **SSL Certificates**: Place `.pem` files in the `ssl/` directory for SSL termination.

## Notes

- The `ssl/README.md` file serves as a placeholder and should be removed before running the container.
- The `env` file is ignored by version control for security reasons but is required, so please fill it out.

## License

This code is licensed under the Unlicense. Please see: https://unlicense.org/.
