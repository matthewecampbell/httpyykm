require "minitest/autorun"
require "minitest/pride"
require "./lib/router"
require "pry"

class RouterTest < Minitest::Test

  def test_if_path_is_slash
  router = Router.new("/")
  end


end
