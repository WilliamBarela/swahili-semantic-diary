# Swahili Semantic Diary (SSD)

Swahili Semantic Diary is an application which is intended to help learners of Kiswahili to improve their vocabulary. Vocabulary building is one of the most dificult aspects of language learning, expecially in a target language where most lexemes have no shared roots with the learner's mother tongue. Swahili is a language with a very regular morphology with few exceptions as it is an agglutinative language. Despite that regularity, it is also challenging to a learner whose L1 language is not Bantu based since it has a much higher number of classes of declensions for nouns which impact both verb conjugation and adjective declinsion. This app helps acts as a person journal/diary for the language learner while allowing for a vocabulary gloss with grammatical information to ensure that new words are effectively learned. Furthermore, there are few applications which assist L2 Swahili learners. With this application, I hope to reduce this void.

The underlying database which has been chosen for this project is PostgreSQL. This `README` should provide basic information on how to get this application up and running so that one can focus on modifying it according to ones needs.

## Dependencies
The installation of PostgreSQL is highly dependent on the OS one chooses as is RVM. Once these dependencies are met, please skip to the set up section for detail on how correctly set up and configure PostgreSQL and RVM.

- [PostgreSQL 11](https://www.postgresql.org/download/ "PostgreSQL 11")
- [PostgreSQL 11 Installation](https://wiki.postgresql.org/wiki/Apt "PostgreSQL 11 Installation")
- [RVM](https://rvm.io/ "RVM")
- [Ruby 2.7.0](https://www.ruby-lang.org/en/ "Ruby 2.7.0")
- [Rails 6.0.2.2](https://github.com/rails/rails/tree/v6.0.2.2 "Rails 6.0.2.2")

## Set up
### Use RVM to install Ruby 2.7.0.

```bash
rvm install 2.7.0

# if you wish to use Ruby 2.7.0 by default, run:
rvm --default use 2.7.0
```

### Install necessary Ruby gems (including Rails)

```bash
# update your gems:
gem update --system

# if you want to save disk space, run:
echo "gem: --no-ri --no-rdoc" >> $HOME/.gemrc

gem install rails -v 6.0.2.2
gem install bundler pg pry rspec

# command used to set up files for Rails to use PostgreSQL (don't run):
# rails new rails_university --database=postgresql

# from rails version 6.0.0, Webpacker has been the default Javascript manager in Rails.
# as a result, you will need to install Webpacker and you will need to install Yarn which it depends on

# installing yarn:
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# if you don't have node, run this to install yarn:
# sudo apt update && sudo apt install yarn
# if you already use node, install yarn like this:
sudo apt update && sudo apt install --no-install-recommends yarn

# installing webpacker:
rails webpacker:install
```

For more basic information on using Rails, please see both the short `rails_guide.md` which was written for this project and the Official Rails Guide.
Also, for more information on yarn and the lastest installation instructions, please see [yarn's documentation](https://classic.yarnpkg.com/en/docs/install#debian-stable "yarn's documentation").

### Create user in PostgreSQL 11  for swahili_semantic_diary

```bash
# create a superuser (name is your choice, but you have to use it in your config/database.yml:
sudo -u postgres createuser -s university

# drop into PostgreSQL and change your password securely:
sudo -u postgres psql

postgres=# \password university
```
### Aside - Useful commands if one drops into PostgreSQL directly:

```sql
-- list all roles;
\du

-- drop database:
drop database database_name;

-- drop role:
drop role database_role;

-- list all databases:
\l

-- connect to a database
\c university_development

-- describe database (i.e., show tables)
\d

-- describe a table (i.e., show columns of a given table:
\d a_tables_name

-- show just a list of columns/fields and data types of a given table:
SELECT
  COLUMN_NAME, DATA_TYPE
FROM
  information_schema.COLUMNS
WHERE
  TABLE_NAME = 'cats';
```

One can connect to the database directly using psql in the CLI:

```bash
psql -h localhost_or_database_host -p database_port -U postgresql_user database_name
```

- [PostgreSQL Tutorials](https://www.tutorialspoint.com/postgresql/postgresql_select_database.htm "PostgreSQL Tutorials")
- [PostgreSQL data types](https://www.postgresql.org/docs/11/datatype-numeric.html "PostgreSQL data types")

### Install gems from Rails Gemfile:

```bash
bundle install
```

### Configure the config/database.yml file:
If you are running PostgreSQL locally, make sure to inlcude the `host: localhost` statement.
Else, you will not be able to run your setup or migrations.
NOTA BENE: DO NOT keep your username, password, or even the name of the database in your version control.
If you do not trust yourself with this, run `echo "config/database.yml" >> .gitignore` before your next commit.

```yml
# vim config/database.yml

default: &default
  adapter: postgresql
  encoding: unicode
  host: localhost
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: rails_university_development
  username: university
  password: FILL_IN_YOUR_PASSWORD_FOR_university_HERE

test:
  <<: *default
  database: rails_university_test
  username: university
  password: FILL_IN_YOUR_PASSWORD_FOR_university_HERE
```

### Create your databases through Rails using your PostgreSQL user for the app:

```bash
# create the databases based on config/database.yml
rake db:setup

# complete your migrations
rake db:migrate
```

### Set up is complete!

You now have a working Ruby on Rails application set up with your database. If you get any errors about fileutils and ENV variables already being set, you most likely just have an old version of fileutils installed in your gems. To solve this, run:

```bash
gem uninstall fileutils
gem update fileutils --default
```

### Footnotes for PostgreSQL

```bash
# if you want to verify the permissions that have been granted to the PostgreSQL user
sudo -u postgres psql
postgres=# \du

# if you want to verify in PostgreSQl that the databases have been created:
sudo -u postgres psql
postgres=# \l
```

### Later migrating your database

Please heed the warning in `db/schema.rb` when trying to recreate your database on a new machine:

```ruby
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.
```

## Future Design Features to Implement

In creating this web application, following Rails convention over configuration ideology was followed as closely as possible.
However, there are several considerations for longivity, ease of migration upon EOL of the various components of the application and scalability which would make overiding certain conventions which Rails has as default a better idea.
This section will list those additional configuration (some which are Rails specific and some which are PostgreSQL specific).

### Using UUIDs for All Simple Primary Keys for All Tables

When developing a database, one must take into consideration several factors when choosing primary keys. Space is a limiting factor and indeed one of the primary concerns.
However, in the spirit of being forward looking for scaling purposes, thinking about future growth of your database and migrations, it is important to choose a primary key which has a low probability of collissions.
Another very important issue is to consider is security. Using a "natural key" such as a national identification number, or a student ID in a database might be convenient.
However, since these items would cause a security risk in case your database were compromised, it is a very poor and lazy practice for a database such as that of a university department's website (which should only be a means of presenting information).
As a result, in this generalized rails application, I have chosen to use a "surrogate key", in specific UUIDs, for all simple primary keys in all tables.
Universally Unique Identifiers, UUIDs, have had various standards which have been developed over the years and which continue to be used.

Version-1 UUIDs are generated using the creation timestamp of a record and the MAC address of the node (i.e., the computer generating the UUID).
This ensures uniqueness of any given UUID; however, it comes at the cost of security as any given UUID publishes the MAC address of the computer with your database.

Version-4 UUIDs are randomly generated ids which are composed of 128bits, six of which are used to indicate the version and varient.
There are not guaranteed to be unique due to the random nature of their generation; however, the probabily of generating a UUID which causes a collision is so exceedingly low that for all intents and purposes, they may be considered unique.
The [probability](https://en.wikipedia.org/wiki/Universally_unique_identifier "uuid probability") of finding a single duplicate in 103 x 10^12 UUIDs is about one in a billion.
Thus, given the scale of the population of a large university department (or even a university for that matter) over the course of a lifetime, it is exceedingly unlikely that a collision will be generated using version-4 UUIDs as primary keys.

PostgreSQL 11's module "pgcrypto" offers a version-4 UUID generator which can be used for making primary keys. Ruby on Rails also allows for this integration.

- [pgcrypto with Rails](https://lab.io/articles/2017/04/13/uuids-rails-5-1/ "Using pgcrypto in Rails")
- [PostgreSQL pgcrypto](https://www.postgresql.org/docs/current/pgcrypto.html "PostgreSQL pgcrypto module for generating UUIDs")

## How to use

### Move `config/database.yml.bak`
Assuming you followed the steps in the above set up exactly, you can follow the subsequent steps to get running

```bash
mv config/database.yml.bak config/database.yml
```

### Read about encrypted credentials in Rails 5.2

- [Rails Encrypted](https://www.engineyard.com/blog/rails-encrypted-credentials-on-rails-5.2 "Rails Encrypted Credentials")

to be continued ...

## Additional Useful Links

- [Rails and Postgresql](https://medium.com/@frouster/ruby-on-rails-postgresql-f1b037924bdf "Rails & PostgreSQL with Useful Commands")
- [PostgreSQL 11 Documentation](https://www.postgresql.org/docs/11/index.html "PostgreSQL 11 Documentation")
- [PostgreSQL 11 Client Applications](https://www.postgresql.org/docs/11/reference-client.html "PostgreSQL 11 Client Applications")
- [Dockerize PostgreSQL](https://docs.docker.com/engine/examples/postgresql_service/ "Dockerize PostgreSQL")
- [Secure TCP/IP Connections with SSH Tunnels](https://www.postgresql.org/docs/11/ssh-tunnels.html "Secure TCP/IP Connections with SSH Tunnels")
- [PostgreSQL Security](https://www.digitalocean.com/community/tutorials/how-to-secure-postgresql-on-an-ubuntu-vps "PostgreSQL Security (dated, but useful)")
