# Granting permissions to read_only by database

## postgrest_bond_reporting 
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting     -c "GRANT USAGE ON SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting     -c "GRANT SELECT ON ALL TABLES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting     -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting     -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting     -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON SEQUENCES TO read_only;"

## postgrest_knack_services
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services  -c "GRANT USAGE ON SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services  -c "GRANT SELECT ON ALL TABLES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services  -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services  -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services  -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON SEQUENCES TO read_only;"

## postgrest_legacy_scripts
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT USAGE ON SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT SELECT ON ALL TABLES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON SEQUENCES TO read_only;"

## postgrest_parking
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking         -c "GRANT USAGE ON SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking         -c "GRANT SELECT ON ALL TABLES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking         -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking         -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking         -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON SEQUENCES TO read_only;"

## postgrest_road_conditions
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT USAGE ON SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT SELECT ON ALL TABLES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA api, public TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON TABLES TO read_only;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT SELECT ON SEQUENCES TO read_only;"


# Granting permissions to read_write by database


# postgrest_bond_reporting
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "GRANT USAGE ON SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_bond_reporting -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# postgrest_knack_services
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "GRANT USAGE ON SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_knack_services -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# postgrest_legacy_scripts
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT USAGE ON SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_legacy_scripts -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# postgrest_parking
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "GRANT USAGE ON SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_parking -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# postgrest_road_conditions
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT USAGE ON SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api, public TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON TABLES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT ALL PRIVILEGES ON SEQUENCES TO read_write;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -d postgrest_road_conditions -c "ALTER DEFAULT PRIVILEGES IN SCHEMA api, public GRANT EXECUTE ON FUNCTIONS TO read_write;"

# Delete the role `ctr_user`
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "DROP ROLE IF EXISTS ctr_user;"

docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "\
REVOKE CONNECT ON DATABASE 
moped, moped_staging, 
vision_zero, vision_zero_staging, 
postgrest_bond_reporting, 
postgrest_knack_services, 
postgrest_legacy_scripts, 
postgrest_parking, 
postgrest_road_conditions 
FROM api_user,
atd_user,
postgrest_app,
postgrest_web_anon;"


# grant connect to postgrest_app
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE 
postgrest_bond_reporting, 
postgrest_knack_services, 
postgrest_legacy_scripts, 
postgrest_parking, 
postgrest_road_conditions  
TO postgrest_app;"

# this was just plain ol' wrong, and this fixes it
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE read_write FROM postgrest_app;"

# set NOINHERIT on the postgrest_app role so it can't write by way of being a member of [api_user, atd_user] which bear read_write
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE postgrest_app NOINHERIT;"

# we need to revoke and then re-grant the roles that postgrest_app can assume. 
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE postgrest_web_anon FROM postgrest_app;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE api_user FROM postgrest_app;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE atd_user FROM postgrest_app;"

# set the roles postgrest_app can "SET ROLE" to, which it must since it's NOINHERIT. Postgrest works under the hood with "SET ROLE."
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT postgrest_web_anon TO postgrest_app;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT api_user TO postgrest_app;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT atd_user TO postgrest_app;"

docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE postgrest_app RENAME TO postgrest_admin;"
