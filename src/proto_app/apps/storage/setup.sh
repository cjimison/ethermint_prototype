#!/bin/bash

# Setup the Database in CockroachDB
mix ecto.create

mix ecto.gen.migration users
# Init the tables
#mix ecto.gen.migration app_namespace

# GO fill out the db info in the private/repo/migrations/<timestamp>_app_namespaces.exs file
#mix ecto.gen.migration apps

# GO fill out the db info in the private/repo/migrations/<timestamp>_apps.exs file

# go create the tables in the db
mix ecto.migrate
