require 'sinatra'
require 'sinatra/reloader'
require './model/menu.rb'

# index for mobile
get '/mobiles' do
  @menus = Menu.where("day >= :start AND day <= :end",
                        {start: (Date.today + 2).beginning_of_week, end: (Date.today + 2).end_of_week}
                       ).order("day ASC, id DESC").group(:day)
  erb :mobile, layout: :application
end

# index
get '/menus' do
  @menus = Menu.where("day >= :start AND day <= :end",
                        {start: (Date.today + 2).beginning_of_week, end: (Date.today + 2).end_of_week}
                       ).order("day ASC, id DESC").group(:day)
  erb :index, layout: :application
end
get '/menus.json' do
  @menus = Menu.where("day >= :start AND day <= :end",
                        {start: (Date.today + 2).beginning_of_week, end: (Date.today + 2).end_of_week}
                       ).order("day ASC, id DESC").group(:day)
  obj = @menus.map{|menu| {id: menu.id, day: menu.day, lunch1: menu.lunch1, lunch2: menu.lunch2, dinner: menu.dinner, url: "https://menus.kumano-ryo.com/menus/#{menu.id}.json"}}
  JSON.pretty_generate(obj)
end

# new
get '/menus/new' do
  @menu = Menu.new
  erb :new, layout: :application
end

get '/menus/*.json' do |id|
  @menu = Menu.find(id)
  JSON.pretty_generate({id: @menu.id, day: @menu.day, lunch1: @menu.lunch1, lunch2: @menu.lunch2, dinner: @menu.dinner, created_at: @menu.created_at, updated_at: @menu.updated_at})
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
post '/menus.json' do
  @menu = Menu.new(params.slice(:day, :lunch1, :lunch2, :dinner))
  if @menu.save
    status 201
    body JSON.pretty_generate({id: @menu.id, day: @menu.day, lunch1: @menu.lunch1, lunch2: @menu.lunch2, dinner: @menu.dinner, created_at: @menu.created_at, updated_at: @menu.updated_at})
  else
    status 422
    body JSON.pretty_generate(@menu.errors)
  end
end

# update
patch '/menus/*.json' do |id|
  @menu = Menu.find(id)
  if @menu.update(params.slice(:day, :lunch, :lunch2, :dinner))
    status 200
    body JSON.pretty_generate({id: @menu.id, day: @menu.day, lunch1: @menu.lunch1, lunch2: @menu.lunch2, dinner: @menu.dinner, created_at: @menu.created_at, updated_at: @menu.updated_at})
  else
    status 422
    body JSON.pretty_generate(@menu.errors)
  end
end
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
