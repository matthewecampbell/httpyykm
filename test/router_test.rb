require "minitest/autorun"
require "minitest/pride"
require "./lib/router"
require "pry"

class RouterTest < Minitest::Test

  def test_if_path_is_just_slash
    router = Router.new("/")

    assert_equal "/", router.determine_path
  end

  def test_if_path_is_hello
    router = Router.new("/hello")

    assert_equal "Hello, World", router.determine_path
  end


  def test_if_path_is_word_search
    router = Router.new("/word_search?word=horse")

    assert_equal "horse is a known word", router.check_dictionary
  end

  def test_cant_do_plural
    router = Router.new("/word_search?word=horses")

    assert_equal "horses is not a known word", router.check_dictionary
  end

  def test_can_do_capitals
    router = Router.new("/word_search?word=Horse")
    assert_equal "Horse is a known word", router.check_dictionary
    router = Router.new("/word_search?word=HoRse")
    assert_equal "HoRse is a known word", router.check_dictionary
  end

  def test_cant_use_made_up_word
    router = Router.new("/word_search?word=aserwef")
    assert_equal "aserwef is not a known word", router.check_dictionary
  end
end
