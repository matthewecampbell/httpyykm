require "minitest/autorun"
require "minitest/pride"
require "./lib/router"
require "./lib/game"
require "pry"

class RouterTest < Minitest::Test
attr_reader     :router
  def setup
    game = Game.new
    @router = Router.new(game)
  end

  def test_if_path_is_just_slash
    assert_equal "/", router.determine_path("GET", "/")
  end

  def test_if_path_is_hello
    assert_equal "Hello, World", router.determine_path("GET", "/hello")
  end


  def test_if_path_is_word_search
    assert_equal "horse is a known word", router.check_dictionary("/word_search?word=horse")
  end

  def test_cant_do_plural
    assert_equal "horses is not a known word", router.check_dictionary("/word_search?word=horses")
  end

  def test_can_do_capitals
    assert_equal "Horse is a known word", router.check_dictionary("/word_search?word=Horse")

    assert_equal "HoRse is a known word", router.check_dictionary("/word_search?word=HoRse")
  end

  def test_cant_use_made_up_word
    assert_equal "aserwef is not a known word", router.check_dictionary("/word_search?word=aserwef")
  end

  def test_start_game
    assert_equal "Good luck!", router.determine_path("POST", "/start_game")
  end

  def test_no_guesses_made
    assert_equal "You have not made any guesses yet.", router.determine_path("GET", "/game")
  end

  def test_game_is_created
    assert_instance_of Game, router.game
  end

  def test_can_give_strftime
    assert_instance_of String, router.hash["/datetime"]
  end

end
