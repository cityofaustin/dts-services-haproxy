# This file should be run prior to the project specific ones because it sets the CONNECT permissions
# for the `PUBLIC` role.


# The permissions shuffle


# change our policy about what developers can do with their roles
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "REVOKE read_write FROM developers;"
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT read_only TO developers;"

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
FROM 
berryc,
clarkem,
claryj,
developers,
dilleym,
eichelmannr,
henryc,
herefordf,
read_only,
read_write,
whitsont,
PUBLIC;"

# developers, developers, developers, developers, developers, developers, yeah!
docker run --rm -it --env-file ./credentials_for_throw_away_server postgres:16 psql -c "GRANT CONNECT ON DATABASE 
moped, moped_staging, 
vision_zero, vision_zero_staging, 
postgrest_bond_reporting, 
postgrest_ctr_data_lake, 
postgrest_knack_services, 
postgrest_legacy_scripts, 
postgrest_parking, 
postgrest_road_conditions 
TO developers;"
