require 'socket'
require 'pry'

class Server


  tcp_server = TCPServer.new(9292)
  counter = 0
  loop do
    counter += 1
    client = tcp_server.accept

    puts "Ready for a request"
    request_lines = []

    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    puts "Got this request:"
    puts request_lines.inspect
    puts "Sending response."
    response = "<pre>\n
    Verb: POST\n
    Path: /\n
    Protocol: HTTP/1.1\n
    Host: 127.0.0.1\n
    Port: 9292\n
    Origin: 127.0.0.1\n
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n
    </pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")



      client.puts headers
      client.puts output

      client.puts "Hello World #{counter}"
      client.close
    end
  end
