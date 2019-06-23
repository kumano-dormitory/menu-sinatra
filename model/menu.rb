require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'menus.sqlite3')
class Menu < ActiveRecord::Base; end
