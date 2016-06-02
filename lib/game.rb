class Game
attr_reader :guesses,
            :guess_counter,
            :randnum

  def initialize
    @guesses = []
    @guess_counter = guesses.count
    @randnum = randnum ||= rand(1..100)
  end

  def record_guess(guess)
    guesses << guess
  end

#   def check_guess_count
#     if guess_count == 0
#       client.puts "#{guess_count} guess"
#     elsif guess_count > 0
#       feedback(guess)
#     end
#   end
#
#   def feedback(guess)
#     if guess == randnum
#       client.puts "Correct!"
#     elsif guess < randnum
#       client.puts "Too low."
#     elsif guess > randnum
#       client.puts "Too high."
#     end
#   end
#
#
#   # def check_guess
#   #  if guesses.last == randnum
#   #
#   # end
#
# #
# #   def check_guess
# #       if < too low, etc.
# #         need to ensure string response is the last thing in this method
# #         then this method will be called in router, which communicates back to parser, which communicates back to router which communicates back to serverb
#   end
end
