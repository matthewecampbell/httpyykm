class Game
attr_reader :guesses,
            :randnum

  def initialize
    @guesses = []
    @randnum = rand(1..100)
  end

  def record_guess(guess)
    guesses << guess
  end

  # def check_guess
  #  if guesses.last == randnum
  #
  # end

#
#   def check_guess
#       if < too low, etc.
#         need to ensure string response is the last thing in this method
#         then this method will be called in router, which communicates back to parser, which communicates back to router which communicates back to serverb
#   end
end
