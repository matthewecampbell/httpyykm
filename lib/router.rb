require "pry"

class Router
  attr_reader       :path,
                    :hash

def initialize(path)
  @path              = path
  @hash              = {"/" => "/", "/hello" => "Hello, World", "/datetime" => Time.now.strftime("%I:%M%p on %A, %b %e, %Y"), "/shutdown" => "Total Requests:"}
end

def determine_path
  if path.include?("/word_search?word=")
    check_dictionary
  else
   hash[path]
  end
end

def check_dictionary
  response = ""
  word = path.split("=")[1]
  answer = File.readlines("/usr/share/dict/words").one? do |element|
    element.chomp.upcase == word.upcase
  end
  if answer == true
    response += "#{word} is a known word"
  elsif answer == false
    response += "#{word} is not a known word"
  end
  response
end

end
