# HTTP? Yeah, You Know Me!

This was my third project in module 1 at Turing School of Software and Design.  The goal was to get a greater understanding of HTTP requests,
specifically GET and POST requests.  The spec required that we build a server in ruby that accepts HTTP requests and returns responses based on the request.

#### Usage

Clone down the project.
```
git clone http://github.com/matthewecampbell/httpyykm
```
CD into the project.
```
cd httpyykm
```


To run the server, from the root project folder run:
```
`ruby lib/httpyykm.rb`
``

**The server runs at address http://127.0.0.1:9292**

The functionality of the server includes appropriate response codes and the following commands:

**GET Requests**<br>
* `/`
 * This request to the root will return general information including:
    * Verb
    * Path
    * Protocol
    * Host
    * Origin
    * Accept
    * Content-Length (POST requests only)
* `/hello`
  * Returns "Hello, World!" along with the number of times that the path '/hello' has been reached this session.
* `/datetime`
  * Returns the Date and Time.
* `/shutdown`
  * Returns the total number of requests and shuts down the server.
* `/word_search?word=(your word here)`
  * Returns either `WORD is a known word` or `WORD is not a known word` depending on the results of your machine's local dictionary.
* `/game`
  * If a game has been started, it will respond with how many guesses have been taken and whether the most recent guess was too low or too high.


**POST Requests**<br>
* `/start_game`
  * Returns "Good luck!" and starts a game where your machine has chosen a number between 0 and 100.
* `/game?guess`
  * This post request allows you to make a guess. The server takes your guess and then redirects you to '/game' and will respond 
   showing you your number of guesses and if your guess was correct, too high, or too low.
