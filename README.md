[![Build Status](https://travis-ci.org/j3ck/billboard.svg?branch=master)](https://travis-ci.org/j3ck/billboard)
[![Code Climate](https://codeclimate.com/github/j3ck/billboard/badges/gpa.svg)](https://codeclimate.com/github/j3ck/billboard)
#Billboard

---

Test task for Twinslash

This branch used Cloudinary for image uploading.


[Heroku]

[Heroku]:http://billboard-2014.herokuapp.com/

Example admin:

    email: admin@admin.com
    password: 123123123
Example user with seed:

    email: user@user.com
    password: 123123123
Example user with populate task:

    email: example-#{N}@user.com
    password: 123123123
>where N is the number from 1..30

Setup
=====

```sh
git clone git@github.com:j3ck/billboard.git
```

```sh
bundle install
```
* configurate config/database.yml
* configurate config/app_keys.yml
* download config/cloudinary.yml
* create database
with seed data use
```sh
rake db:setup
```
with full sample populate db
```sh
rake db:create
rake db:migrate
rake billboard:populate
```
* start whenever tasks
```sh
whenever -i
```
* start server
```sh
rails s
```
