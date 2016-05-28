require "minitest/autorun"
require "minitest/pride"
require "./lib/parser"
require "pry"

class ParserTest < Minitest::Test
  attr_reader :parser

def setup
  @parser = Parser.new(["POST / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"])
end

def test_get_verb
  assert_equal "Verb: POST", parser.get_verb
end

def test_get_path
  assert_equal "Path: /", parser.get_path
end

def test_get_protocol
  assert_equal "Protocol: HTTP/1.1", parser.get_protocol
end

# def test_get_host
#   assert_equal "Host: 127.0.0.1", server.get_host
# end

# def test_return_output_which_is_parsed_and_formatted_request
#   request = ["POST / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"]
#
#   output = "<pre>\nVerb: POST\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"
#   server = Server.new(from_browser)
#
#   assert_equal output, server.parse_request
# end
end
