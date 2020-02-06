require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)
set :atts, 12
@@cheat = false

get '/' do
  @@cheat = params['cheat']
  number = "xx"
  guess = params['guess']
  if guess.nil?
    game_over
  end
  eval = eval_guess(guess)
  message = eval[0]
  show = eval[1]
  css = eval[2]
  if show
    number = settings.secret_number
  end
  erb :index, :locals => {:num => number, :msg => message, :css => css}
end

def eval_guess(n)
  settings.atts -= 1
  puts settings.atts
  msg = ""
  show = false
  color_hex = '#ffffff'
  unless n.nil?
    n = n.to_i
    diff = n - settings.secret_number
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
  if @@cheat
    msg << " (Psst..#{settings.secret_number})"
  end
  css = 
  "
  <style>
      body {
        background: #{color_hex};
      }
    </style>
  "
  if !show && settings.atts<=0
    return game_over
  end
  return [msg, show, css]
end

def game_over
  css = 
  "
  <style>
      body {
        background: '#000000';
      }
    </style>
  "
  msg = "Game Over, refresh page to start over! The secret number was #{settings.secret_number}"
  show = true
  settings.secret_number = rand(100)
  settings.atts = 12
  return [msg, show, css]
end
