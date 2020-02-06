require 'sinatra'
require 'sinatra/reloader'

random_num = rand(100)

get '/' do
  # "The SECRET NUMBER is #{random_num}"
  # throw params.inspect
  if params['guess'].nil?
    erb :index, :locals => {:num => "xx", :msg => 'oof'}
  else
    diff = params['guess'].to_i - random_num
    case diff
    when 1..5
      erb :index, :locals => {:num => "xx", :msg => 'Too high bro' }
    when -5..-1
      erb :index, :locals => {:num => "xx", :msg => 'Too low bro' }
    when 5..Float::INFINITY
      erb :index, :locals => {:num => "xx", :msg => 'Way Too high bro' }
    when -Float::INFINITY..-5
      erb :index, :locals => {:num => "xx", :msg => 'Way Too low bro' }
    else
      erb :index, :locals => {:num => random_num, :msg => 'bullseye bro' }
    end
  end
end


