require 'pry'
require "./lib/router"

class Parser
  attr_reader :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def get_verb
    "Verb: #{request_lines[0].split[0]}"
  end

  def get_path
    router = Router.new(request_lines[0].split[1])
    router.determine_path
  end

  def get_protocol
    "Protocol: #{request_lines[0].split[2]}"
  end

  def get_host
    "Host:#{request_lines[1].split(":")[1]}"
  end

  def get_port
    "Port: #{request_lines[1].split(":")[2]}"
  end

  def get_origin
    "Origin:#{request_lines[1].split(":")[1]}"
  end

  def get_accept
    accept = ""
    request_lines.each do |element|
      if element.include?("Accept:")
      accept += element
      end
    end
    "Accept:#{accept.split(":")[1]}"
  end

  def final_response
    if get_path == "/"
      ("\n") + get_verb + ("\n") +
      "Path: #{get_path}" + ("\n") +
      get_protocol + ("\n") +
      get_host + ("\n") +
      get_port + ("\n") +
      get_origin + ("\n") +
      get_accept + ("\n")
    else
      get_path
    end
  end

  # def parse_request_lines
  #   verb = [] #contains only the text that would go after "Verb:"
  #   first_el_split = request_lines[0].split(" ")
  #   verb << first_el_split[0]
  #   "Verb: #{verb.join}"
  # end

  # tcp_server = TCPServer.new(9292)
  # counter = 0
  # loop do
  #   counter += 1
  #   client = tcp_server.accept
  #
  #   puts "Ready for a request_lines"
  #   request_lines_lines = []
  #
  #   while line = client.gets and !line.chomp.empty?
  #     request_lines_lines << line.chomp
  #   end
  #
  #   puts "Got this request_lines:"
  #   puts request_lines_lines.inspect
  #   puts "Sending response."
  #   response = "<pre>" + request_lines_lines.join("\n") + "</pre>"
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
