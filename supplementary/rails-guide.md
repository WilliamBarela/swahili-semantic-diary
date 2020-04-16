# Rails Guide

## What is an Ruby on Rails?

Ruby on Rails is a **Model** **View** **Controller** (MVC) framework which is very powerful and values convention over configuration.
MVC is a common pattern for web applications and seeks to ensure separtation of concerns within the code base.
In addition to this, there are also several other features which make it easy for a developer to quickly build out a web application.
Rails can be very feature filled and allows for several other classes including a testing framework, mailers, and storage classes.

## What is an MVC? How does it connect to the database?

### Migrations
A web application without persistance in a database can only be classed as little more than a front-end.
As a result, one could write SQL to connect to the database and persist these values; however, that is brittle as it locks you into the SQL specification of one given database.
Thus, Rails also has migration classes which are stored in `$YOUR_RAILS_APP_DIR/db/migrations`.
Migrations are Ruby classes as well which inherit from the `ActiveRecord::Migration` class.
They are an **ORM** (objection relationship mapping) which allows for database independance (Rails is open source and many people have worked hard to include the SQL equivalent across several different RDBMS'.)
Migration classes specify which fields to add to which tables and what datatype they should be classed as.
Migrations also act as something of a version control system which you can use to communication from Rails to your database and go back to a previous moment in the databases development.
In sum, migrations allow your Rails application to communicate with your database, creating and droping tables, adding and removing fields, and specifying field types.

### Models
Models inherit from `ApplicationRecord` which in turn inherits from `ActiveRecord::Migrations`
As it is implemented in Rails, the models are the Ruby classes housed in `$YOUR_RAILS_APP_DIR/app/models`.
Models are the classes which contain the business logic of your application. Here you will write **Active Record Validations** which will be run on new instances of your objects.
Here you will also specify the connections and cardinality among your tables using **Active Record Associations**
Models classes, at their most basic form, serialize the data input into an instance of an object by the classes name.
They also reveal fundamental CRUD operations (Create, Read, Update, and Delete) to your rails application.


#### CRUD operations

##### Create (Klass.create, Object.save)
Thus, upon instantiating an instance of the model class `Dog`, `fido = Dog.new("fido")` an object is stored in memory.
However, if one were to exit the rails consoles after creating that instance, it would be garbage collected.
If one would like to persist this serialized object the database, one could type `fido.save`.
These operations of serializing the input data and then persiting to the database is the create operation and can be done by simply typing `Dog.create("fido")`.

##### Read (Klass.all, Klass.find(), etc.)
Since read operations inherently are leveraging the power of SQL queries, there are a plethora of differnt methods which one can use to read from ones database.
The full set of queries which have been implemented for supported databases are shown in the **Active Record Query Interface** docs.
One is also free to create ones own custom SQL queries; however, this has to be done with caution due to the risk of SQL injection attacks.

##### Update (e.g.: user = Klass.find_by(first_name: 'Elissa'); user.update(last_name: 'Khoury')
Just as in a SQL query we have to select a given record to update it, here too we have to use a read operation to first serialize the database record into a Ruby object which we can alter its data and then update the record in the database.
We can also update all records as well using the update_all method of the class which was inherited from ApplicationRecord: Klass.update_all "max_login_attempts = 3, must_change_password = 'true'".

##### Delete (program = Klass.find_by(name: 'sharepoint'); program.destroy)
Again, here we must first complete a query to reserilize the record into a Ruby object; then, we delete the record from the database.

#### Active Record Associations:
In Rails, we can leverage Active Record Associations to connect our models. This allows us to have one to one, one to many, many to many, and other relationships.
Please see the docs on AR Associations for full details.

### Controllers
Controllers provide up to seven basic RESTful model methods which determine what the HTTP verbs used to contact your applicaiton do.
In specific, they orchestrate the basic framework (which can be customized as you see fit) of receiving HTTP requests and translating those into calls on your models for queries and then specify which views should be presented.
Controllers also have the very important task of sanitizing such requests by using the private methods and params to control what fields are available.
Params is an absolute necessity to ensure security of your database so that malicious HTTP request cannot get what it requests.

## Generating Migrations, Models, Controllers, Resources, Scaffolds, etc.
For full details, please refer to the **Active Record Migrations** docs. For a quick reference, run `rails generate --help`

The rails cli utility offers many time saving shortcuts which allow you to flesh out a 
a working application in a few in the terminal. Rails of course is a very opinionated
framework and it sets up several defaults which you may need to adjust to your needs.

The principle generators which you can employ are migration, model, and scaffold.
The order reflects the least to the most complex (and hence from fewer to more files created).
Rails scaffold generator in particular is very powerful if you need to quickly build out a full featured application.
However, if misused, it will actually just create a of bloat.

All generators are invoked through the cli with this syntax: `rails generate` and then the name of the generator.
A shortcut for this is `rails g` and then the generator you require.

This section will focus on the basics of this. One very useful flag which one can pass to `rail g` is the `-p` flag which will give you a preview of what the migration will do.
If you wish to delete all files associated with the migration, you instead invoke `rails d migration` on the referent migration.
Running `rails d migration` will not rollback migrations which you have completed using `rake db:migrate`! So, be careful when invoking this command and make sure that you have rolled back any associated migrations; else, you will need to connect to your databased and do the clean up manually.

### Migrations
Although they are not strictly migrations, it is important to know how to create databases and drop databases from Rails.
When first downloading this application, you should run `rake db:setup` this will reference `$YOUR_RAILS_APP_DIR/config/database.yml` and create the databases specified in that config file.
The opposite of this is completed by running `rake db:drop`.

Now, back to migrations. Again, to emphasize, migrations perform non-record level operations on your database. Hence, you can create or drop tables with them, create or drop columns/fields, but no record level opearations are performed (i.e., CRUD operations which are handled by Models).
They also serve as a somewhat basic version control system for defining and reverting non-record based changes. That said, when migrating a database to a new server, one should not use these migrations as this could be faulty. It is better to make a database dump to use on the new system.

#### CREATE TABLE:

##### SQL

```sql
CREATE TABLE users (
  id bigint PRIMARY KEY,
  name character varying,
  age integer,
  is_star_trek_fan boolean);
```

##### Rails generator equivalent:

```bash
rails g migration CreateUsers name:string age:integer is_star_trek_fan:boolean`
```

Using `rails g migration CreateZZZ` followed by a set of key value pairs will invoke active_record and generate a new table ZZZ to be set up in your database with columns/fields for each key of the data type specified by the value.

```bash
Running via Spring preloader in process 8962
      invoke  active_record
      create    db/migrate/20190421040854_create_user.rb
```

Thus, only one file is generated, the one in `db/migrate`
This is the associated `db/migrate/*_create_user.rb` file:

```ruby
class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.boolean :is_star_trek_fan
    end
  end
end
```
The resultant table which is created in PostgreSQL can be seen below. It is the same for both the SQL as well as the Rail generator:

```sql
university_development=# 
SELECT
  COLUMN_NAME, DATA_TYPE
FROM
  information_schema.COLUMNS
WHERE
  TABLE_NAME = 'users';

-- output:

   column_name    |     data_type
------------------+-------------------
 id               | bigint
 name             | character varying
 age              | integer
 is_star_trek_fan | boolean
(4 rows)

university_development=# \d users_pkey

-- output: 

      Index "public.users_pkey"
 Column |  Type  | Key? | Definition
--------+--------+------+------------
 id     | bigint | yes  | id
primary key, btree, for table "public.users"

```

To actually create the table in your database, you then need to run `rake db:migrate` which invokes the outstanding migrations.
If you decide that you did not want to do this, you can run `rake db:rollback` which will attempt to reverse the migrations just performed.
If you decide that you also want to delete all files associated with the migration, then run `rails d migration CreateUser`.

#### ALTER TABLE ADD COLUMN

##### SQL

```sql
ALTER TABLE users 
ADD COLUMN last_name character varying;
```

##### Rails generator equivalent:

```bash
rails g migration AddLastNameToUsers last_name:string
```

Using `rails g migration AddYYYToUsers` followed by a key value pair of the column/field to add and the data type will generate a migration which upon invoking `rake db:migrate` will add column YYY to the table `users`.

```bash
Running via Spring preloader in process 9029
      invoke  active_record
      create    db/migrate/20190421071910_add_last_name_to_users.rb
```
Again, as migration generator, this will only generate one file in db/migrate
The associated file is `db/migrate/*_add_last_name_to_user.rb`

```ruby
class AddLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string
  end
end
```
The structure produced by the SQL and Rails is the follow:

```sql
university_development=#
SELECT
  COLUMN_NAME, DATA_TYPE
FROM
  information_schema.COLUMNS
WHERE
  TABLE_NAME = 'users';

-- output

   column_name    |     data_type
------------------+-------------------
 id               | bigint
 name             | character varying
 age              | integer
 is_star_trek_fan | boolean
 last_name        | character varying
(5 rows)
```
`rails g migration RemoveLastNameFromUsers` will generate a migration which will remove the last_name field from the users table.

If one would like to associate a foreign key with one of the fields of the table, one can run: `rails g migration AddPersonRefToOrders person:references`. The equivalent of this in PostgreSQL if one were to make the table:

```sql
CREATE TABLE Orders (
    OrderID int NOT NULL PRIMARY KEY,
    OrderNumber int NOT NULL,
    PersonID int REFERENCES Persons(PersonID)
);
```

#### Creating a Join Table

##### SQL
```sql
CREATE TABLE "customer_products" (
  "customer_id" bigint NOT NULL, 
  "product_id" bigint NOT NULL);
```
##### Rails generator equivalent:
```bash
rails g migration CreateJoinTableCustomerProduct customer product
```

Further information about migrations in Rails can be found in the **Active Record Migrations** docs.

### Models

Model generators must be invoked using the singular. Models generate the migration (plural) in `db/migration/`, the model (singular) in `app/models/` and testing units by default.

```bash
rails g model User first_name:string last_name:string age:integer
Running via Spring preloader in process 10249
      invoke  active_record
      create    db/migrate/20190422003414_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
```

Models also add a timestamp to the migration files by default (which does not happen when you create a stand alone migration).

### Controllers

Controller generators must be invoked in the plural. Controller generators create both the controllers and the views which are associated with them. Unlike resource generators, they do not create the resourceful routes in `config/routes.rb`...and that's a good thing when one is making nested routes.

```bash
rails g controller People
Running via Spring preloader in process 11600
      create  app/controllers/people_controller.rb
      invoke  erb
      create    app/views/people
      invoke  test_unit
      create    test/controllers/people_controller_test.rb
      invoke  helper
      create    app/helpers/people_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/people.coffee
      invoke    scss
      create      app/assets/stylesheets/people.scss
```

### Resources

Resource generators must be invoked in the singular. Resources generate  the same classes as a model generator (the migration, the model, the test_unit); however, they also generate the controllers and their helper methods and the resourceful routing by default.
In essense, `rails g resource` is equivalent to `rails g model` and `rails g controller` combined without the resourceful routes being included (i.e., the additional line in `config/routes.rb`).

```bash
rails g resource Person
Running via Spring preloader in process 11240
      invoke  active_record
      create    db/migrate/20190426055410_create_people.rb
      create    app/models/person.rb
      invoke    test_unit
      create      test/models/person_test.rb
      create      test/fixtures/people.yml
      invoke  controller
      create    app/controllers/people_controller.rb
      invoke    erb
      create      app/views/people
      invoke    test_unit
      create      test/controllers/people_controller_test.rb
      invoke    helper
      create      app/helpers/people_helper.rb
      invoke      test_unit
      invoke    assets
      invoke      coffee
      create        app/assets/javascripts/people.coffee
      invoke      scss
      create        app/assets/stylesheets/people.scss
      invoke  resource_route
       route    resources :people
```

### Useful Rake Task Added in this Code Base

All migrations must be invoked using `rake`. If one uses `rails` instead, it will still work because rails will route the migration to rake to complete the database operation which needs to be completed.
To see what rake tasks are available by default, please run 

```bash
rake --tasks
```

However, oftentimes one might wonder what SQL was used to generate the particular migration which you invoked using either `rake db:migrate` or `rake db:rollback`.

There is a rake task which has been added to lib/tasks/log.rake:

```ruby
task :log => :environment do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
```

Thus, if one invokes `rake log db:migrate` or `rake log db:rollback`, one can see exactly what rails has done and what SQL command was used to complete a particular migration.

### Data types available in PostgreSQL and implemented in Ruby on Rails:
PostgreSQL has a very rich support for several different datatypes. However, as Rails and the, pg gem in particular, is acting as an ORM which communicates with PostgreSQL and one
of the main purposes of Rails is to provide cross functionality across several different RDBMS, only a limited set of the following datatypes are supported (still quite a few):

##### PostgreSQL Data Types:

![PostgreSQL 11 Data Types](https://raw.githubusercontent.com/WilliamBarela/rails_micro_udept/people_migrations/specifications/assets/postgresql_11_data_types.png "PostgreSQL 11 Data Types")

From Rails ActiveRecord > connection adapters > postgresql adapter

```ruby
class PostgreSQLAdapter < AbstractAdapter
  ADAPTER_NAME = "PostgreSQL"

  ##
  # :singleton-method:
  # PostgreSQL allows the creation of "unlogged" tables, which do not record
  # data in the PostgreSQL Write-Ahead Log. This can make the tables faster,
  # but significantly increases the risk of data loss if the database
  # crashes. As a result, this should not be used in production
  # environments. If you would like all created tables to be unlogged in
  # the test environment you can add the following line to your test.rb
  # file:
  #
  #   ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.create_unlogged_tables = true
  class_attribute :create_unlogged_tables, default: false

  NATIVE_DATABASE_TYPES = {
    primary_key: "bigserial primary key",
    string:      { name: "character varying" },
    text:        { name: "text" },
    integer:     { name: "integer", limit: 4 },
    float:       { name: "float" },
    decimal:     { name: "decimal" },
    datetime:    { name: "timestamp" },
    time:        { name: "time" },
    date:        { name: "date" },
    daterange:   { name: "daterange" },
    numrange:    { name: "numrange" },
    tsrange:     { name: "tsrange" },
    tstzrange:   { name: "tstzrange" },
    int4range:   { name: "int4range" },
    int8range:   { name: "int8range" },
    binary:      { name: "bytea" },
    boolean:     { name: "boolean" },
    xml:         { name: "xml" },
    tsvector:    { name: "tsvector" },
    hstore:      { name: "hstore" },
    inet:        { name: "inet" },
    cidr:        { name: "cidr" },
    macaddr:     { name: "macaddr" },
    uuid:        { name: "uuid" },
    json:        { name: "json" },
    jsonb:       { name: "jsonb" },
    ltree:       { name: "ltree" },
    citext:      { name: "citext" },
    point:       { name: "point" },
    line:        { name: "line" },
    lseg:        { name: "lseg" },
    box:         { name: "box" },
    path:        { name: "path" },
    polygon:     { name: "polygon" },
    circle:      { name: "circle" },
    bit:         { name: "bit" },
    bit_varying: { name: "bit varying" },
    money:       { name: "money" },
    interval:    { name: "interval" },
    oid:         { name: "oid" },
      }
```

- [PostgreSQL Data Types Implemented in RoR](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb#L69 "PostgreSQL Data Types Implemented in RoR")
- [PostgreSQL Data Types Reference](https://www.postgresql.org/docs/11/datatype.html "PostgreSQL Data Types Reference")
