require 'socket'
require './lib/parser'

class Server
attr_reader       :tcp_server

  def initialize
    @tcp_server    = TCPServer.new(9292)
  end

  def accept_lines
    client = tcp_server.accept
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    response = "<pre>" + Parser.new(request_lines).final_response + "</pre>"
    # we are going to chain our methods in Parser and call it here - i.e. final reponse in above line
    # we know that Parser.new(request).final_response is a nicely formatted string with new lines already inside
    output = "<html><head></head><body>#{response}</body></html>"
    client.close
  end
end

server = Server.new
parser = Parser.new(server.accept_lines)
