# National Centre for Excellence for Language Pedagogy

![](app/assets/images/NCELP-logo-orange-long-plus-strap.png)

## About us

The National Centre for Excellence for Language Pedagogy (NCELP) is funded by the Department for Education (DfE) and co-managed by The University of York and The Cam Academy Trust.

We work in partnership with university researchers, teacher educators and expert practitioners, and with 18 Specialist Teachers in nine Leading Schools across the country acting as language hubs, to improve language curriculum design and pedagogy, leading to a higher take up and greater success at GCSE.

Our substantial package of support includes professional development tools, teaching resources, and workshops, and takes forward the recommendations made in the Teaching Schools Council’s Modern Foreign Languages Pedagogy Review led by headteacher and linguist Ian Bauckham, and ensures they are achievable and effective in schools.

## Quick start
0. Assume that Docker is avaiable
```
❯ docker-compose --version                                                                 ═
docker-compose version 1.24.1, build 4667896b
```
Generate local ssh key
```
ssh-keygen -i rsa docker/ncelp_id_rsa
```

1. Set .env with Docker variables. Use .env.template as starting point
```
cp .env.template .env
```
Customise as required

2. Set config/application.yml
```
ncelp_host: http://localhost:3000
development:
  application_database_adapter: postgresql
  application_database_name: ncelp
  application_database_host: postgresdb
  # application_database_host: 127.0.0.1
  application_database_username: ncelp
  application_database_password: ncelp
  #derivatives_path: tmp/ncelp-derivatives
  fedora_base_path: /ncelp-development
  # fedora_url: http://127.0.0.1:8080/fcrepo/rest
  fedora_url: http://fcrepo:8080/fcrepo/rest
  # fits_path: /Users/sp1487/fits-1.4.1/fits.sh
  fits_path: /fits/fits.sh
  log_level: error
  redis_namespace: ncelp-public
  realtime_notifications: 'false'
  redis_host: redis
  redis_port: '6379'
  # solr_url: http://127.0.0.1:8983/solr/hyrax_production
  solr_url: http://solr:8983/solr/hyrax_production
  # Generate and add secrets `rails secrets`   
  # secret_key_base: 

```
3. Build docker images. Note this will take up to 1h depending on network and laptop speed.
```
❯ docker-compose build 

# Check images builded
❯ docker-compose images                                                                  ═ ✹
      Container                  Repository              Tag        Image Id      Size  
----------------------------------------------------------------------------------------
ncelp-mac_app_1          ncelp-mac_app                latest      ebe2e4e5e2db   3 GB   
ncelp-mac_fcrepo_1       ualbertalib/docker-fcrepo4   4.7         15806dadb895   575 MB 
ncelp-mac_postgresdb_1   postgres                     11-alpine   da01ecfbabe1   68.5 MB
ncelp-mac_redis_1        redis                        5           de25a81a5a0b   93.7 MB
ncelp-mac_solr_1         solr                         7-alpine    64cb096f9679   286 MB 
ncelp-mac_web_1          ncelp-mac_web                latest      ebe2e4e5e2db   3 GB   
```
4. Start your docker stack
```
❯ docker-compose up
...
lots of logs
...

# Check status from an other terminal
❯ docker-compose ps                                                                  ⏎ ═ ✹ ✚
         Name                       Command                   State                Ports         
-------------------------------------------------------------------------------------------------
ncelp-mac_app_1          irb                              Exit 0                                 
ncelp-mac_fcrepo_1       catalina.sh run                  Up               0.0.0.0:8080->8080/tcp
ncelp-mac_postgresdb_1   docker-entrypoint.sh postgres    Up (unhealthy)   0.0.0.0:5432->5432/tcp
ncelp-mac_redis_1        docker-entrypoint.sh redis ...   Up (healthy)     0.0.0.0:6379->6379/tcp
ncelp-mac_solr_1         solr-precreate hyrax_produ ...   Up (healthy)     0.0.0.0:8983->8983/tcp
ncelp-mac_web_1          /bin/docker-entrypoint-web.sh    Up               0.0.0.0:3000->3000/tcp
```
The local source code is shared with Docker ${APP_DIR} volume. Any changes to .erb files, while running rails servers  in development mode, will be seen instantly. Changes to gems and new *.rb will require rebuild image. This should be faster as the process is staged.   

The build process will create qazwsx:ncelp-admin@york.ac.uk admin user. Use this link to sign in http://127.0.0.1:3000/users/sign_in
