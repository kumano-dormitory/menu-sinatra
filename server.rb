require 'sinatra'
require 'sinatra/reloader'
require './model/menu.rb'

get '/menus' do
  @menus = Menu.where("day >= :start AND day <= :end",
                        {start: (Date.today + 2).beginning_of_week, end: (Date.today + 2).end_of_week}
                       ).order("day ASC, id DESC").group(:day)
  erb :index, layout: :application
end

# new
get '/menus/new' do
  @menu = Menu.new
  erb :new, layout: :application
end

# show
get '/menus/:id' do
  @menu = Menu.find(params[:id])
  erb :show, layout: :application
end

# edit
get '/menus/:id/edit' do
  @menu = Menu.find(params[:id])
  erb :edit, layout: :application
end

# create
post '/menus' do
  @menu = Menu.new(params.slice(:day, :lunch1, :lunch2, :dinner))
  if @menu.save
    redirect "/menus/#{@menu.id}", 303
  else
    erb :create, layout: :application
  end
end

# update
patch '/menus/:id' do
  @menu = Menu.find(params[:id])
  if @menu.update(params.slice(:day, :lunch1, :lunch2, :dinner))
    redirect "/menus/#{@menu.id}", 303
  else
    erb :update, layout: :application
  end
end

# destroy
delete '/menus/:id' do
  @menu = Menu.find(params[:id])
  @menu.destroy
  redirect '/menus', 303
end
