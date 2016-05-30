class Router

def initialize(path)
  @hash = {
  "/" => "/"
  "/hello" => "Hello, World"
  "/datetime" => Time.now.strftime("%m:%M%p on %A, %b %e, %Y")
  "/shutdown" => "Total Requests: #{counter}"
}
end

def determine_path
  hash(path)
end

end
