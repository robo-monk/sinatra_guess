require 'sinatra'
require 'sinatra/reloader'

set :SECRET_NUMBER, rand(100)

get '/' do
  number = "xx"
  guess = params['guess']
  eval = eval_guess(guess)
  message = eval[0]
  show = eval[1]
  css = eval[2]
  if show
    number = settings.SECRET_NUMBER
  end
    erb :index, :locals => {:num => number, :msg => message, :css => css}
end

def eval_guess(n)
  msg = ""
  show = false
  color_hex = '#ffffff'
  unless n.nil?
    n = n.to_i
    diff = n - settings.SECRET_NUMBER
    case diff
    when 1..5
      msg = 'Too high bro'
      color_hex = '#f18484'
    when -5..-1
      msg = 'Too low bro'
      color_hex = '#f18484'
    when 5..Float::INFINITY
      msg = 'Way Too high bro'
      color_hex = '#ff0a0a'
    when -Float::INFINITY..-5
      msg = 'Way Too low bro'
      color_hex = '#ff0a0a'
    else
      msg = "bullseye bro the number is #{n}"
      show = true
      color_hex = '#68e86a'
    end
  end
  css = 
  "
  <style>
      body {
        background: #{color_hex};
      }
    </style>
  "
  return [msg, show, css]
end


