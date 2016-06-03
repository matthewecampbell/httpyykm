require 'socket'
require './lib/router'
require './lib/parser'
require './lib/game'
require "pry"
require './lib/redirects'

class Server
  include Redirects
  attr_reader       :tcp_server,
                    :router,
                    :parser,
                    :game,
                    :verb,
                    :path,
                    :guess

  def initialize
    @tcp_server     = TCPServer.new(9292)
    @game           = Game.new
    @router         = Router.new(game)
    @parser         = Parser.new(self)
  end

  def start
    @hello_counter   = 0
    counter         = 0
    loop do
      counter += 1
      client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end #want to make method here to line 39
      store_guess(request_lines, client)
      response = @parser.final_response(request_lines)
      output = generate_output(response, counter)
      server_response(client, output, response)
    end
  end

  def header(output)
    if router.determine_path(@verb, @path, @guess) == "Valid POST for /game"
      self.guess_redirect(output)
    else
      self.default(output)
    end
  end

  def find_output(type, arg)
    case type
    when "Hello, World"
      response = "Hello, World #{arg}"
    when "Total Requests:"
      response = "Total Requests: #{arg}"
    else
      response = type
    end
      "<html><head></head><body><pre>#{response}</pre></body></html>"
    end

  def store_guess(request_lines, client)
    @verb = request_lines[0].split[0]
    @path = request_lines[0].split[1]
    num = @parser.get_content_length(request_lines)
    read_client = client.read(num).split(" ")[4]
    if read_client != nil && game.game_start
      @guess = read_client.to_i
      if router.determine_path(@verb, @path, @guess) == "Valid POST for /game"
        game.record_guess(@guess)
      end
    end
  end

    def server_response(client, output, response)
      client.puts header(output)
      client.puts output
      client.close
      @tcp_server.close if response == "Total Requests:"
    end

    def generate_output(response, counter)
      if response == "Hello, World"
        @hello_counter += 1
        output = find_output("Hello, World", @hello_counter)
      elsif response == "Total Requests:"
        output  = find_output("Total Requests:", counter)
      else
        output  = find_output(response, nil)
      end
    end
  end
