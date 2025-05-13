# Granting permissions to read_only by database

## vision_zero
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT USAGE ON SCHEMA geo, hdb_catalog, lookups, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT SELECT ON ALL TABLES IN SCHEMA geo, hdb_catalog, lookups, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA geo, hdb_catalog, lookups, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT SELECT ON SEQUENCES TO read_only;"

## vision_zero_staging
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT USAGE ON SCHEMA geo, hdb_catalog, lookups, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT SELECT ON ALL TABLES IN SCHEMA geo, hdb_catalog, lookups, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA geo, hdb_catalog, lookups, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT SELECT ON SEQUENCES TO read_only;"

# Granting permissions to read_write by database

## vision_zero
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT USAGE ON SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

## vision_zero_staging
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT USAGE ON SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA geo, hdb_catalog, lookups, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d vision_zero_staging -c "ALTER DEFAULT PRIVILEGES IN SCHEMA geo, hdb_catalog, lookups, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# The permissions shuffle

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
FROM apostolx,
kordem,
meyerj,
vision_zero_app,
vision_zero_readers;"


# grant connect to RR groups
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE moped, moped_staging TO moped_readers;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE vision_zero, vision_zero_staging TO vision_zero_readers;"
