require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "./lib/router"
require "pry"

class GameTest < Minitest::Test
attr_reader :game
  def setup
    @game = Game.new
    game.record_guess(3)
  end

  def test_records_guess
    assert_equal 3, game.guesses.last
  end

  def test_can_assert_guess_correct
    game.randnum = 3
    assert_equal "correct!", game.check_guess
  end

  def test_can_say_guess_too_low
    game.randnum = 10
    assert_equal "too low.", game.check_guess
  end

  def test_can_say_guess_too_high
    game.randnum = 1
    assert_equal "too high.", game.check_guess
  end

  def test_game_not_start
    refute game.game_start
  end

  def test_can_hold_guesses
    refute game.guesses.empty?
  end

  def test_can_count_guesses
    assert_equal 1, game.guesses.count
  end

  def test_can_create_randnum
    assert_instance_of Fixnum, game.randnum
  end
end
