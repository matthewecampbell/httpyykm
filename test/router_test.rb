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


end
