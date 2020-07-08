require 'open-uri'
require 'bundler/setup'
Bundler.require

#ActiveRecord::Base.establish_connection(
#  adapter: 'mysql2',
#  host:     "localhost",
#  username: "root",
#  password: "!Green0909!",
#  database: "simple_anime"   
#
DB_ENV ||= 'development'
connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details[DB_ENV])

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'app'
