# Docker Rails App

Ruby on rails development Environment.

## Docker

### Please look at docker-compose.yml and make sure you change the 3 spots where volumes are specified. mba-orig is for your source code, then you need a directory for MySQL and finally a directory for gemstash.

volumes:<br>
      - */home/ray/mba-orig-next*:/mba-orig<br>
      - */home/ray/mba-mysql*:/var/lib/mysql<br>
      - */home/ray/rails-next-docker*:/root/.gemstash<br>

To build:

- run `docker-compose build`

To run:

- run `docker-compose up -d`

In another window change to your app source directory - as you can see in docker-compose.yml mine is /home/ray/mba-orig-next

Then start your IDE. I use VS Code.

```
code .
```
Make sure that gem unicorn is uncommented!

Also check out your docker network

`docker inspect rails-next-docker_default`

Back to your first window - to get into your MySQL container

- run `docker exec -it mba_mysql /bin/bash`

To drop directly into MySQL

- run `docker exec -it mba_mysql mysql -uroot -pMys3267!`

- run `create database mba_development;`
      `exit`

Copy the database from www1 - it's called backup05012020

*To get new data from db1*

  `mysqldump -u root -pnIxie57bis% globalauth_production > yourbackupname.sql`

  *Copy backup of www database from DB1 to www - Do this from www*

  `scp -P 30022 globalauth@10.176.160.74:~/yourbackupname.sql ~/yourbackupname.sql`

```
docker exec -i mba_mysql mysql -u root --password=Mys3267! mba_development < ~/yourbackupname.sql
```

It'll take a while but you should be up with MySQL!  Do NOT use an IP address for MySQL, just use mysql for the Host name in config/database.yml. Remember, I used port 3307 for MySQL!

host in database.yml should be set to `mysql`

To get into your rails container

- run `docker exec -it mba_rails /bin/bash`

This will drop you into your home directory

`bundle install`

`bundle exec unicorn_rails -c config/unicorn.conf`

You should be up on localhost:8081 

To exit bash or your container:

- run `exit` or ctrl D

To cleanup:

- run `docker-compose down`

## Rails

Stopping the server:

- hit `ctrl-c` on your keyboard to stop the server.

# MBA-Docker

To get rid of all the deprecation warnings insert - `ActiveSupport::Deprecation.silenced = true` in development.rb
