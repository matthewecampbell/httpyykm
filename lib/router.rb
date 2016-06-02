require "./lib/game"
require "pry"

class Router
  attr_reader       :verb,
                    :path,
                    :hash,
                    :game

  def initialize(game)
    @game = game
    @hash              = {"/" => "/", "/hello" => "Hello, World", "/datetime" => Time.now.strftime("%I:%M%p on %A, %b %e, %Y"), "/shutdown" => "Total Requests:", "/start_game" => "Good luck!", "/game?guess" => "redirect"}
  end

  def determine_path(verb, path, guess = nil)
    if path.include?("/word_search?word=")
      check_dictionary(path)
    elsif path.include?("/start_game") && verb == "POST"
      game.game_start = true
      hash[path]
    elsif path.include?("/game") && verb == "GET"
      if game.guesses.count == 0
        "You have not made any guesses yet."
      else
        "You have made #{game.guesses.count} guess(es). Your guess was #{game.guesses.last}. Your guess was #{game.check_guess}"
      end
    elsif path.include?("/game") && verb == "POST" && guess != nil
      "Valid POST for /game"
    else
     hash[path]
    end
  end

  def check_dictionary(path)#put method in module - or maybe new WordSearch class
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


end
