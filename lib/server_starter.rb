require './lib/server'

class ServerStarter
  def initialize
    server = Server.new
    server.start
  end
end

ServerStarter.new
