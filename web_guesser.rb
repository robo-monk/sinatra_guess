require 'sinatra'
require 'sinatra/reloader'

random_num = rand(100)

get '/' do
  # "The SECRET NUMBER is #{random_num}"
  erb :index, :locals => {:num => random_num}
end
