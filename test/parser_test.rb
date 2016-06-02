require "minitest/autorun"
require "minitest/pride"
require './lib/server'
require "./lib/parser"
require "./lib/router"
require "pry"

class ParserTest < Minitest::Test
  attr_reader :parser, :request_lines, :server, :router

  def parser_possibilities
    @parser = Parser.new(self)
    @router = Router.new(self)
    @request_lines = (["POST / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"])
  end

  def test_get_verb
    parser_possibilities

    assert_equal "Verb: POST", parser.get_verb(request_lines)
  end

  def test_get_path
    parser_possibilities

    assert_equal "/", parser.get_path(request_lines)
  end

  def test_get_protocol
    parser_possibilities

    assert_equal "Protocol: HTTP/1.1", parser.get_protocol(request_lines)
  end

  def test_get_host
    parser_possibilities

    assert_equal "Host: 127.0.0.1", parser.get_host(request_lines)
  end

  def test_get_port
    parser_possibilities

    assert_equal "Port: 9292", parser.get_port(request_lines)
  end

  def test_get_origin
    parser_possibilities

    assert_equal "Origin: 127.0.0.1", parser.get_origin(request_lines)
  end

  def test_get_accept
    parser_possibilities

    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", parser.get_accept(request_lines)
  end

  def test_final_response
    parser_possibilities

    assert_equal "\nVerb: POST\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8\n", parser.final_response(request_lines)
  end

  def test_final_response_if_path_hello
    skip
    parser = Parser.new(self)
    router = Router.new(self)

    assert_equal "Hello, World", parser.final_response(["POST /hello HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"])
  end

  def test_final_response_if_path_datetime
    parser = Parser.new(self)

    assert_instance_of String, parser.final_response(["POST /datetime HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"])
  end

  def test_final_response_if_path_shutdown
    skip
    parser = Parser.new(self)
    router = Router.new(self)

    assert_equal "Total Requests:", parser.final_response(["POST /shutdown HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"])
  end

  def test_get_verb_if_post_and_path_include_start_game
    server = Server.new
    parser = Parser.new(server)
    request_lines = (["POST /start_game HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"])

    assert_equal "Verb: POST", parser.get_verb(request_lines)
    assert_equal "Good luck!", parser.get_path(request_lines)
    assert_equal "Good luck!", parser.final_response(request_lines)
  end

end
