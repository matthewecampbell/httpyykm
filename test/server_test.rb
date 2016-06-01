require "minitest/autorun"
require "minitest/pride"
require "./lib/server"
require "faraday"
require "pry"

class ServerTest < MiniTest::Test
attr_reader      :conn #, :connection

  # def test_if_server_exists
  #   s = Server.new
  #   assert_instance_of Server, s
  # end

  #
  # def test_faraday_connects
  #   connection = Faraday.get("http://127.0.0.1:9292")
  #   assert_equal 1, connection.headers
  # end

  def test_get_root
    Faraday.get("http://127.0.0.1:9292")
  end


  # def setup
  #   @conn = Faraday::Connection.new "http://127.0.0.1:9292/"
  # end
  #
  #
  # def test_initialize_parses_host_out_of_given_url
  # assert_equal '127.0.0.1', conn.host
  # end
  #
  # def test_port_is_9292
  #   assert_equal 9292, conn.port
  # end
  #
  # def test_prefix
  #   assert_equal Hash.new, conn.params
  # end


  # def test_return_output_which_is_parsed_and_formatted_request
  #   assert_equal ("User-Agent" => "Faraday v0.9.2"), conn.headers
  # end
  #
  # def test_faraday_connects
  #   skip
  #   connection = Faraday.new(:url => "http://127.0.0.1:9292/")
  #   connection.get'/hello'
  #   # assert_equal "Hello, World", faraday.response
  # end

end
