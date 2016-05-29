require 'socket'
require './lib/parser'

class Server
attr_reader       :tcp_server
attr_accessor     :request_lines, :client

  def initialize
    @tcp_server    = TCPServer.new(9292) #---> possibly make this TCP.Server.new(9292).accept
  end

  def receive_request
    @client = tcp_server.accept
    @request_lines = []
    while line = client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    @request_lines
  end

  def respond_to_client
    response = "<pre>" + Parser.new(@request_lines).final_response + "</pre>"
    # we are going to chain our methods in Parser and call it here - i.e. final reponse in above line
    # we know that Parser.new(request).final_response is a nicely formatted string with new lines already inside
    output = "<html><head></head><body>#{response}hellyeah</body></html>"
    @client.puts output
    @client.close
  end
end

server = Server.new
server.receive_request
server.respond_to_client

# parser = Parser.new(server.receive_request)
