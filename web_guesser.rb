require 'sinatra'
require 'sinatra/reloader'

random_num = rand(100)

get '/' do
  "The SECRET NUMBER is #{random_num}"
end
