require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '/var/db/menus.sqlite3')
class Menu < ActiveRecord::Base; end
