require 'sinatra'
require './model/menu.rb'

get '/' do
  erb :index
end
