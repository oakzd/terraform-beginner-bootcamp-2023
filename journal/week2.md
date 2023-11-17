# Terraform Beginner Bootcamp 2023 week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby. It is primary way to install ruby packages (gems).

#### Install Gems
You need to create a Gemfile and define your gems in that file.

```ruby

source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally.
A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler
We use `bundle exec` to tell future ruby scripts to use those gems we installed.

#### Sinatra

Sinatra is a micro web-framework for ruby to build webapps

Great for development servers or for very simple projects. You can build a web-server in a single file


https://sinatrarb.com/


## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following. All of the code for the server
is stored in the `server.rb` file
```ruby
bundle install
bundle exec ruby server.rb
```

## CRUD

Terraform Provider resources utilize CRUD.

CRUD = Create, read, update and delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete