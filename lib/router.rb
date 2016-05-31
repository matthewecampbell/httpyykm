require "pry"

class Router
  attr_reader       :path,
                    :hash

def initialize(path)
  @path              = path
  @hash              = {"/" => "/", "/hello" => "Hello, World", "/datetime" => Time.now.strftime("%I:%M%p on %A, %b %e, %Y"), "/shutdown" => "Total Requests:"}
end

def determine_path
  hash[path]
end



end
