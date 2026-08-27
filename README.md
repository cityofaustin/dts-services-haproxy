# DTS Services HAProxy

This repository contains the configuration and setup for an HAProxy service used to manage traffic for various applications and services. The HAProxy instance is configured to handle HTTP, HTTPS, and PostgreSQL traffic.

## Repository Structure

- `docker-compose.yaml`: Defines the Docker Compose configuration for running the HAProxy container.
- `haproxy.cfg`: The main configuration file for HAProxy, defining frontends, backends, and ACLs.
- `trusted_sources_internal.lst.example` / `trusted_sources_citybase.lst.example`: Templates for the IP/CIDR allowlists. Copy these to the gitignored `.lst` filenames before starting the container (see [Trusted source allowlists](#trusted-source-allowlists)).
- `env-template`: Environment variables template file, containing sensitive information like the database server address. This file is ignored by `.gitignore`.
- `ssl/`: Directory for SSL certificates and keys. Contains a `README.md` with instructions for adding `.pem` files.
  - `equitytool.austinmobility.io.pem`: Example SSL certificate and key file.
- `.dockerignore`: Specifies files and directories to exclude from Docker builds. This file is a symlink of `.gitignore`.
- `.gitignore`: Specifies files and directories to exclude from version control. The live `trusted_sources_*.lst` files are ignored so real IPs are not committed.

## Prerequisites

- Docker and Docker Compose installed on your system.
- SSL certificates in `.pem` format placed in the `ssl/` directory.
- A valid `env` file with the required environment variable.
- Live allowlist files `trusted_sources_internal.lst` and `trusted_sources_citybase.lst` (Docker will fail to start without them).

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
   ```

4. Copy the allowlist templates and replace the placeholder IPs with real values:

   ```bash
   cp trusted_sources_internal.lst.example trusted_sources_internal.lst
   cp trusted_sources_citybase.lst.example trusted_sources_citybase.lst
   ```

5. Start the HAProxy service using Docker Compose:

   ```bash
   docker compose up -d
   ```

6. Watch the logs if needed:
   ```bash
   docker compose logs -f
   ```

## Configuration

- **HAProxy Configuration**: Modify `haproxy.cfg` to update frontends, backends, and ACLs as needed.
- **Environment Variables**: Update the `env` file to point to the correct database server.
- **SSL Certificates**: Place `.pem` files in the `ssl/` directory for SSL termination.
- **Trusted sources**: Edit the live `.lst` files (not the `.example` templates) and keep 1Password in sync, as described below.

## Trusted source allowlists

Ports 80 and 443 are open to the internet. HAProxy then uses two gitignored IP/CIDR lists to decide who can reach which backends. PostgreSQL on 5432 is also restricted to the internal list.

- `trusted_sources_internal.lst` — developers and the city network. Can reach every backend, including PostgreSQL.
- `trusted_sources_citybase.lst` — Citybase source IPs. Can reach Citybase hosts only.

Access policy:

- **umami**: public
- **citybase** hosts: internal list **or** citybase list
- **everything else** (postgrest, equitytool, PostgreSQL): internal list only

Copies of the live lists live in the 1Password Developer vault as **Bastion HAProxy Trusted Sources Citybase** and **Bastion HAProxy Trusted Sources Internal / Developers**. Changing a 1Password entry does not update the bastion; when you add or remove an IP, update the files on the bastion **and** the matching 1Password entries.

Background on why these lists exist, how they relate to AWS security groups, and what still needs to stay in SGs: [PR #12 discussion](https://github.com/cityofaustin/dts-services-haproxy/pull/12#discussion_r3769198712).

## Notes

- The `ssl/README.md` file serves as a placeholder and should be removed before running the container.
- The `env` file is ignored by version control for security reasons but is required, so please fill it out.

## License

This code is licensed under the Unlicense. Please see: https://unlicense.org/.
