require 'bundler'
Bundler.require

require_relative '../lib/song'

DB = { conn: SQLite3::Database.new("db/music.db") } # set up a constant, DB, that is equal to a hash that contains our connection to the database

