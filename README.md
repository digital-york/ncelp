# National Centre for Excellence for Language Pedagogy

![](app/assets/images/NCELP-logo-orange-long-plus-strap.png)

## About us

The National Centre for Excellence for Language Pedagogy (NCELP) is funded by the Department for Education (DfE) and co-managed by The University of York and The Cam Academy Trust.

We work in partnership with university researchers, teacher educators and expert practitioners, and with 18 Specialist Teachers in nine Leading Schools across the country acting as language hubs, to improve language curriculum design and pedagogy, leading to a higher take up and greater success at GCSE.

Our substantial package of support includes professional development tools, teaching resources, and workshops, and takes forward the recommendations made in the Teaching Schools Council’s Modern Foreign Languages Pedagogy Review led by headteacher and linguist Ian Bauckham, and ensures they are achievable and effective in schools.

## Quick start
0. Assume that Ruby is avaiable
```
ruby -v
ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-darwin18]
```
1. Set config/application.yml
```
ncelp_host: http://localhost:3000
development:
  application_database_adapter: postgresql
  application_database_name: postgres
  application_database_host: 127.0.0.1
  application_database_username: postgres
  application_database_password: ncelp
  #derivatives_path: tmp/ncelp-derivatives
  fedora_base_path: /ncelp-development
  fedora_url: http://127.0.0.1:8984/rest
  #fits_path: tmp/fits/fits.sh
  log_level: error
  redis_namespace: ncelp-public
  realtime_notifications: 'false'
  redis_host: 127.0.0.1
  redis_port: '6379'
  solr_url: http://127.0.0.1:8983/solr/hydra-development
```
2. Bundle gems
```
bundle install
```
3. Start Fedora and Solr app
```
bundle exec solr_wrapper
bundle exec fcrepo_wrapper
```
4. Run Redis
```
docker pull redis
docker run --rm --name ncelp-redis -d -v $HOME/current/ncelp-mac/tmp/redis-data:/data redis
```
5. Run Postgres DB
```
docker pull postgres
docker run --rm --name ncelp-pg-docker -e POSTGRES_PASSWORD=ncelp -e POSTGRES_USER=postgres -e POSTGRES_DB=postgres -d -p 5432:5432 -v $HOME/current/ncelp-mac/tmp/postgres-data:/var/lib/postgresql/data postgres
```
6. Migrate DB schema
```
bundle exec rails db:migrate RAILS_ENV=development
```
7. Generate Admin sets
```
bundle exec rake hyrax:default_admin_set:create  
```
8. Load default workflows
```
ncelp-mac git:master ❯ bundle exec rake hyrax:workflow:load
```
9. Configure admin user
```
bunlde exec rails c
# Admin role should exists
admin = Role.create(name: "admin")
# admin = Role.find_by(name: "admin")
User.create!(email:"sebastian.palucha@york.ac.uk", password:"qazwsx")
admin.users << User.find_by_user_key("sebastian.palucha@york.ac.uk")
admin.save

```
10. Start rails server
```
bundle exec rails s
```

## How to make 'Download all' button for collections working?

1. Add alias in Apache configuration:

    Alias /zipfiles "YOUR LOCAL FOLDER TO STORE ZIP FILES"
    
2. Setup a cron job to run the following rake task daily:

    RAILS_ENV=production bundle exec rake zipfile:collections[NCELP_URL, YOUR LOCAL FOLDER TO STORE ZIP FILES]

e.g.

    RAILS_ENV=production bundle exec rake zipfile:collections[http://localhost:3000/, /opt/york/digilib/tmp]    
   
3. The frontend, e.g. collection show page should show a 'Download All' button if the zip file for that collection is available.    
