require 'sinatra'
require 'sinatra/reloader'

set :SECRET_NUMBER, rand(100)

get '/' do
  number = "xx"
  guess = params['guess']
  eval = eval_guess(guess)
  message = eval[0]
  show = eval[1]
  if show
    number = settings.SECRET_NUMBER
  end
    erb :index, :locals => {:num => number, :msg => message}
end

def eval_guess(n)
  msg = ""
  show = false
  unless n.nil?
    n = n.to_i
    diff = n - settings.SECRET_NUMBER
    case diff
    when 1..5
      msg = 'Too high bro'
    when -5..-1
      msg = 'Too low bro'
    when 5..Float::INFINITY
      msg = 'Way Too high bro'
    when -Float::INFINITY..-5
      msg = 'Way Too low bro'
    else
      msg = "bullseye bro the number is #{n}"
      show = true
    end
  end
  return [msg, show]
end


