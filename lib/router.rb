require "./lib/game"
require "pry"

class Router
  attr_reader       :verb,
                    :path,
                    :hash,
                    :game

  def initialize
    @game              = Game.new
    @hash              = {"/" => "/", "/hello" => "Hello, World", "/datetime" => Time.now.strftime("%I:%M%p on %A, %b %e, %Y"), "/shutdown" => "Total Requests:", "/start_game" => "Good luck!", "/game?guess" => "redirect"}
  end

  def determine_path(verb, path)
    if path.include?("/word_search?word=")
      check_dictionary(path)
    elsif path.include?("/start_game") && verb == "POST"
      hash[path]
    elsif path.include?("/game") && verb == "GET"
      game.check_guess_count
    elsif path.include?("/game") && verb == "POST"
      # binding.pry
      game.record_guess(path.split("=")[1])
      hash[path.split("=")[0]]
    else
     hash[path]
    end
  end

  def check_dictionary(path)
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

  def accept_guess(guess)
    @game.compare_guess(guess)
  end

end
