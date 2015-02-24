maintainer "Aldo Delgado"
maintainer_email "aldo@popcode.io"
name "custom_postgres"
license "MIT"
description "A chef recipe to create database and user"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.0.1"

depends 'database'
depends 'postgres'
depends 'pg'
