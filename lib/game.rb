class Game
attr_reader     :guesses

attr_accessor   :game_start,
                :randnum

  def initialize
    @game_start = false
    @guesses    = []
    @randnum    = randnum ||= rand(1..100)
  end

  def record_guess(guess)
    guesses << guess
  end

  def check_guess
    if guesses.last == randnum
      "correct!"
    elsif guesses.last < randnum
      "too low."
    elsif guesses.last > randnum
      "too high."
    end
  end
end
