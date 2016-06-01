require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "./lib/router"
require "pry"

class GameTest < Minitest::Test

  def test_records_guess
    router = Router.new("POST", "/game?guess=3")
    game = router.start_game
    router.determine_path

    assert_equal "3", game.guesses.last
  end


end
