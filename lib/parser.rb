require 'pry'

class Parser
  attr_reader     :request_lines,
                  :router,
                  :server

  def initialize(server)
    @server = server
  end

  def get_verb(request_lines)
    "Verb: #{request_lines[0].split[0]}"
  end

  def get_path(request_lines)
    server.router.determine_path(request_lines[0].split[0], request_lines[0].split[1])
  end

  def get_protocol(request_lines)
    "Protocol: #{request_lines[0].split[2]}"
  end

  def get_host(request_lines)
    "Host:#{request_lines[1].split(":")[1]}"
  end

  def get_port(request_lines)
    "Port: #{request_lines[1].split(":")[2]}"
  end

  def get_origin(request_lines)
    "Origin:#{request_lines[1].split(":")[1]}"
  end

  def get_accept(request_lines)
    accept = ""
    request_lines.each do |element|
      if element.include?("Accept:")
      accept += element
      end
    end
    "Accept:#{accept.split(":")[1]}"
  end

  def get_content_length(request_lines)
    content_length = ""
    request_lines.each do |element|
      if element.include?("Content-Length:")
      content_length += element
      end
    end
    "#{content_length.split(": ")[1]}".to_i
  end

  def final_response(request_lines)
    if get_path(request_lines) == "/"
      ("\n") + get_verb(request_lines) + ("\n") +
      "Path: #{get_path(request_lines)}" + ("\n") +
      get_protocol(request_lines) + ("\n") +
      get_host(request_lines) + ("\n") +
      get_port(request_lines) + ("\n") +
      get_origin(request_lines) + ("\n") +
      get_accept(request_lines) + ("\n")
    elsif get_path(request_lines) == "redirect"
      redirect
    else
      get_path(request_lines)
    end
  end
  end

  def pass_guess(guess)
    server.router.accept_guess(guess)
  end

  def redirect
    "HTTP/1.1 301 Moved Permanently
    Location: http://127.0.0.1:9292/game
    Content-Type: text/html; charset=UTF-8
    Date: Fri, 26 Feb 2016 01:55:24 GMT
    Expires: Sun, 27 Mar 2016 01:55:24 GMT
    Cache-Control: public, max-age=2592000
    Server: gws
    Content-Length: 219
    X-XSS-Protection: 1; mode=block
    X-Frame-Options: SAMEORIGIN"
  end
