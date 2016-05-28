require 'pry'

class Parser
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def get_verb
    "Verb: #{request[0].split[0]}"
  end

  def get_path
    "Path: #{request[0].split[1]}"
  end

  def get_protocol
    "Protocol: #{request[0].split[2]}"
  end

  def get_host
    "Host:#{request[1].split(":")[1]}"
  end

  def get_port
    "Port: #{request[1].split(":")[2]}"
  end

  def get_origin
    "Origin:#{request[1].split(":")[1]}"
  end

  def get_accept
    "Accept:#{request[2].split(":")[1]}"
  end

  def final_response
    get_verb + ("\n") +
    get_path + ("\n") +
    get_protocol + ("\n") +
    get_host + ("\n") +
    get_port + ("\n") +
    get_origin + ("\n") +
    get_accept
  end

  # def parse_request
  #   verb = [] #contains only the text that would go after "Verb:"
  #   first_el_split = request[0].split(" ")
  #   verb << first_el_split[0]
  #   "Verb: #{verb.join}"
  # end

  # tcp_server = TCPServer.new(9292)
  # counter = 0
  # loop do
  #   counter += 1
  #   client = tcp_server.accept
  #
  #   puts "Ready for a request"
  #   request_lines = []
  #
  #   while line = client.gets and !line.chomp.empty?
  #     request_lines << line.chomp
  #   end
  #
  #   puts "Got this request:"
  #   puts request_lines.inspect
  #   puts "Sending response."
  #   response = "<pre>" + request_lines.join("\n") + "</pre>"
  #
  #   output = "<html><head></head><body>#{response}</body></html>"
  #   headers = ["http/1.1 200 ok",
  #     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #     "server: ruby",
  #     "content-type: text/html; charset=iso-8859-1",
  #     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  #
  #
  #
  #     client.puts headers
  #     client.puts output
  #
  #     client.puts "Hello World #{counter}"
  #     client.close
  #   end
  end
