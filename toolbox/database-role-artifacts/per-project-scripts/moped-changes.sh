# Granting permissions to read_only by database

## moped
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT USAGE ON SCHEMA deprecated, hdb_catalog, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT SELECT ON ALL TABLES IN SCHEMA deprecated, hdb_catalog, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA deprecated, hdb_catalog, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT SELECT ON SEQUENCES TO read_only;"

## moped_staging
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT USAGE ON SCHEMA deprecated, hdb_catalog, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT SELECT ON ALL TABLES IN SCHEMA deprecated, hdb_catalog, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA deprecated, hdb_catalog, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT SELECT ON SEQUENCES TO read_only;"

# Granting permissions to read_write by database

## moped
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT USAGE ON SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

## moped_staging
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT USAGE ON SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA deprecated, hdb_catalog, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d moped_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA deprecated, hdb_catalog, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# The permissions shuffle

# Set up a moped readers role and grant it to the mmc_gateway role
# and also remove the explicit permissions from mmc_gateway since it has 
# a role group to live in now. This let's us easily add new moped RR users in the future
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "CREATE ROLE moped_readers INHERIT;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT read_only TO moped_readers;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE read_only FROM mmc_gateway;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT moped_readers TO mmc_gateway;"


# revoke connect from everyone 
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "\
REVOKE CONNECT ON DATABASE 
moped, moped_staging, 
vision_zero, vision_zero_staging, 
postgrest_bond_reporting, 
postgrest_ctr_data_lake, 
postgrest_knack_services, 
postgrest_legacy_scripts, 
postgrest_parking, 
postgrest_road_conditions 
FROM mmc_gateway,
moped_app;"


# grant connect to app groups
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE vision_zero, vision_zero_staging TO vision_zero_app;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE moped, moped_staging TO moped_app;"




