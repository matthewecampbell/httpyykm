require "./lib/game"
require "pry"


class Router
  attr_reader       :verb,
                    :path,
                    :hash,
                    :game

def initialize(verb, path)
  @verb              = verb
  @path              = path
  @hash              = {"/" => "/", "/hello" => "Hello, World", "/datetime" => Time.now.strftime("%I:%M%p on %A, %b %e, %Y"), "/shutdown" => "Total Requests:", "/start_game" => "Good luck!"}
end

def determine_path
  if path.include?("/word_search?word=")
    check_dictionary
  elsif path.include?("/start_game") && verb == "POST"
    start_game
    hash[path]
  elsif path.include?("/game?guess=") && verb == "POST"
    game.guesses << path.split("=")[1]
  else
   hash[path]
  end
end

def check_dictionary
  response = ""
  word = path.split("=")[1]
  answer = File.readlines("/usr/share/dict/words").one? do |element|
    element.chomp.upcase == word.upcase
  end
  if answer == true
    response += "#{word} is a known word"
  elsif answer == false
    response += "#{word} is not a known word"
  end
  response
end

def start_game
  @game = Game.new
end

end
