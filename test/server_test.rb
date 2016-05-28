require "minitest/autorun"
require "minitest/pride"
require "./lib/server"
require "pry"

class ServerTest < Minitest::Test

def rips_apart_requests
  server = Server.new
  request = ["POST / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,​*/*​;q=0.8", "Accept-Language: en-us", "Connection: keep-alive", "Accept-Encoding: gzip, deflate", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"]
  output = "<pre>\nVerb: POST\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"
  assert_equal output, server.rip_request
end
end
