echo "Do not run this script, even though it's formatted as a bash script. Copy chunks into a shell.";
exit;

# How to use this script

# 1. Rehydrate a snapshot of the unified database and give it some one-off name; please delete it afterwards. Please do /not/ put the word "unified" in the name, I used "frank-role-sandbox." 
#       I ended up rehydrating maybe 10 or 15 of these while building this script, so I have it so memorized. I can show you easy, please ask. 1 minute to start a rehydration, 5 minutes until you have a live server.

# 2. Get on the bastion, not root, just as you.
# 3. Create a file called `credentials_for_throw_away_server` in your PWD with the following contents, and remove the `#`s:

#PGHOST=<some-database-name-you-picked-above>.cgq9skxulxcb.us-east-1.rds.amazonaws.com ⚠️
#PGPORT=5432
#PGDATABASE=postgres
#PGUSER=postgres
#PGPASSWORD=<pw from "RDS PostgreSQL Unified Database (VZ, Moped, PostgREST) Admin & Service Accounts" in 1pw>

# 4. ⚠️ Confirm to yourself that you /did not/ just put "unified-database.cgq9skxunope.us-east-1.rds.amazonaws.com" as PGHOST in your `credentials_for_throw_away_server` file. 💀
# 5. ⚠️ Check again, because if you did, you're about to put this into production by accident /or worse./ 💀

# 6. Start firing off these commands. You can copy and paste all the way from the 🟢 to the 🛑 in one swoop if you want.
# 7. Test away, it's all yours. LMK if I can help with anything!
#    💥 The testing instructions will destroy the databases. Do not run them in production under any circumstances.


# 🟢 

# ACT 1:
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




# ACT 2:
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




# Intermission

# I ended up coming back through the following section and hand tailoring it for readability
# and a more approachable ordering, as well as adding comments. Just about everything
# above is 🤖 and everything below is 🤓.





# ACT 3:
# The permissions shuffle

# Delete the role `ctr_user`
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "DROP ROLE IF EXISTS ctr_user;"



# Set up a moped readers role and grant it to the mmc_gateway role
# and also remove the explicit permissions from mmc_gateway since it has 
# a role group to live in now. This let's us easily add new moped RR users in the future
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "CREATE ROLE moped_readers INHERIT;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT read_only TO moped_readers;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE read_only FROM mmc_gateway;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT moped_readers TO mmc_gateway;"

# change our policy about what developers can do with their roles
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE read_write FROM developers;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT read_only TO developers;"

# revoke connect from everyone (does not invalidate existing connections, h/t @mdilley for that great question)
# NB, there is a mystery, seemingly ghost role, `PUBLIC` which means "the default." That had me chasing my tail for a while.
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
apostolx,
atd_user,
berryc,
clarkem,
claryj,
developers,
dilleym,
eichelmannr,
henryc,
herefordf,
kordem,
meyerj,
mmc_gateway,
moped_app,
postgrest_app,
postgrest_web_anon,
read_only,
read_write,
vision_zero_app,
vision_zero_readers,
whitsont,
PUBLIC;"

# developers, developers, developers, developers, developers, developers, yeah!
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE 
moped, moped_staging, 
vision_zero, vision_zero_staging, 
postgrest_bond_reporting, 
postgrest_knack_services, 
postgrest_legacy_scripts, 
postgrest_parking, 
postgrest_road_conditions 
TO developers;"

# grant connect to RR groups
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE moped, moped_staging TO moped_readers;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE vision_zero, vision_zero_staging TO vision_zero_readers;"

# grant connect to app groups
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE vision_zero, vision_zero_staging TO vision_zero_app;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE moped, moped_staging TO moped_app;"

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

# 🛑 






# ACT 4:
# Interrogating the database to confirm configuration

# use this query which databases that roles can connect to (🤖+🤓)
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "\
SELECT
  r.rolname    AS role,
  d.datname    AS database,
  has_database_privilege(r.rolname, d.datname, 'CONNECT')
FROM pg_roles r
CROSS JOIN pg_database d
where has_database_privilege(r.rolname, d.datname, 'CONNECT') = 't'
and r.rolname not in (
'pg_checkpoint', 'pg_create_subscription', 'pg_database_owner', 
'pg_execute_server_program', 'pg_monitor', 'pg_read_all_data', 
'pg_read_all_settings', 'pg_read_all_stats', 'pg_read_server_files',
'pg_signal_backend', 'pg_stat_scan_tables', 'pg_use_reserved_connections',
'pg_write_all_data', 'pg_write_server_files', 'postgres',
'rds_ad', 'rds_iam', 'rds_password', 
'rds_replication', 'rds_superuser', 'rdsadmin')
and d.datname not in (
'postgres', 'template0', 'template1')
ORDER BY r.rolname, d.datname; "


# use this query to see what roles can (assume other roles) / (are members of other roles). (🤖+🤓)
# These two abilities come part and parcel. Role assumption is based on role membership.
# keep in mind though, you can set NOINHERIT on a role, and it won't get the privileges of the roles it is a member of 
# and /must/ SET ROLE to adopt its parent's permissions. NOINHERIT is evaluated at GRANT time, not eval-time.
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "\
SELECT
  member_role.rolname AS this_role,
  role.rolname        AS is_a_member_of_this_role_and_can_assume_it_and_gets_its_power
FROM pg_auth_members m
JOIN pg_roles role           ON m.roleid  = role.oid
JOIN pg_roles member_role    ON m.member  = member_role.oid
WHERE member_role.rolname not in (
'pg_checkpoint', 'pg_create_subscription', 'pg_database_owner', 
'pg_execute_server_program', 'pg_monitor', 'pg_read_all_data', 
'pg_read_all_settings', 'pg_read_all_stats', 'pg_read_server_files',
'pg_signal_backend', 'pg_stat_scan_tables', 'pg_use_reserved_connections',
'pg_write_all_data', 'pg_write_server_files', 'postgres',
'rds_ad', 'rds_iam', 'rds_password', 
'rds_replication', 'rds_superuser', 'rdsadmin')
ORDER BY role.rolname, member_role.rolname; "


# H/T to @johnclary for this following query, which shows various permissions
# at the table level for the roles in the database.

SELECT 
    r.rolname AS role_name,
    'crashes' AS table_name,
    has_database_privilege(r.rolname, current_database(), 'CONNECT') AS has_db_connect,
    has_database_privilege(r.rolname, current_database(), 'CREATE') AS has_db_create, 
    has_database_privilege(r.rolname, current_database(), 'TEMPORARY') AS has_db_temp,
    has_table_privilege(r.rolname, 'crashes', 'SELECT') AS has_select,
    has_table_privilege(r.rolname, 'crashes', 'INSERT') AS has_insert,
    has_table_privilege(r.rolname, 'crashes', 'UPDATE') AS has_update,
    has_table_privilege(r.rolname, 'crashes', 'DELETE') AS has_delete,
    has_table_privilege(r.rolname, 'crashes', 'TRUNCATE') AS has_truncate,
    has_table_privilege(r.rolname, 'crashes', 'REFERENCES') AS has_references,
    has_table_privilege(r.rolname, 'crashes', 'TRIGGER') AS has_trigger
FROM 
    pg_roles r
WHERE 
    r.rolcanlogin = true OR r.rolname IN (
        SELECT rolname FROM pg_roles WHERE rolcanlogin = false AND NOT rolname LIKE 'pg_%' AND NOT rolname LIKE 'rds%'
    )
ORDER BY 
    r.rolname;


# Hands on testing

# example of how to set a password for a role which is handy for testing
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE herefordf WITH PASSWORD 'abc123';"

# Login as user to a db for accounts you set the pw to abc123 👆
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d moped -U herefordf 



# Test 1

# for example, 👇 this should get you into testing the most tricky pattern: 
#  1 LOGIN as postgrest_app
#  2 have no RW or RO permissions
#  3 SET ROLE api_user
#  4 have RW permissions
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE postgrest_app WITH PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d postgrest_parking -U postgrest_app

# valid queries to test READ and WRITE in above example

# select * from api.transactions limit 10;
# update api.transactions set duration_min = 66 where id = 80785422;



# Test 2

# here's a "stay in your lane" test, where you can't peek other project's database
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE meyerj WITH PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d moped -U meyerj 

# and frank can peek because he's a developer. No writing though. 
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE herefordf WITH PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d moped -U herefordf

# select project_id, project_name from moped_project limit 10;
# update moped_project set project_name = 'Waffles Drive' where project_id = 1085;

# and moped_app does whatever it wants. 
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE moped_app WITH PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d moped -U moped_app

# select project_id, project_name from moped_project limit 10;
# update moped_project set project_name = 'Waffles Drive' where project_id = 1085;

# this pure anxiety to write, but it illustrates schema modification as good as anything else. ⚠️ 💀 enjoy the thrill?
# drop table moped_pr0ject cascade;



# Test 3

# do a "stay in your lane" test, but from moped to VZ, but as a RR user
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE mmc_gateway PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d vision_zero -U mmc_gateway 

# and xavier can peek because he's a vision_zero_reader. No writing though. 
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE apostolx WITH PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d vision_zero -U apostolx

# select id, crashes.cris_crash_id, crash_timestamp from crashes limit 10;
# update crashes set crash_timestamp = '2061-07-29T00:00:00Z' where id = 224669; -- ☄️

# and vision_zero_app does whatever it wants.
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "ALTER ROLE vision_zero_app WITH PASSWORD 'abc123';"
docker run --rm -it --env-file ./credentials_for_throw_away_server -e PGPASSWORD=abc123 postgres:16 psql -d vision_zero -U vision_zero_app

# select id, crashes.cris_crash_id, crash_timestamp from crashes limit 10;
# update crashes set crash_timestamp = '2061-07-29T00:00:00Z' where id = 224669;
# drop table cra5hes cascade;
