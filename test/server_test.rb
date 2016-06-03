require "minitest/autorun"
require "minitest/pride"
require 'faraday'
require "pry"
require './lib/server'

class ServerTest < MiniTest::Test
attr_reader      :conn

  def setup
    @conn = Faraday::Connection.new "http://127.0.0.1:9292/"
  end

  def test_initialize_parses_host_out_of_given_url
  assert_equal '127.0.0.1', conn.host
  end

  def test_port_is_9292
    assert_equal 9292, conn.port
  end

  def test_prefix
    assert_equal Hash.new, conn.params
  end

  def test_faraday_connects
    connection = Faraday.get("http://127.0.0.1:9292/hello")
    assert_equal 200, connection.status
  end

  def test_faraday_status_when_make_guess
    connection = Faraday.post("http://127.0.0.1:9292/game", :guess => "8")
    assert_equal 200, connection.status
  end

  def test_body
    connection = Faraday.post("http://127.0.0.1:9292/game", :guess => "8")
    assert_instance_of String , connection.body
  end

end
