# Week 6 Sinatra Heroku Example

## Outline

* Developing, testing and deploying web services
  * Rack and Sinatra
  * Rack::Test
  * Heroku
* Exercise
* Exploration
  * Travis Continuous Integration

## Developing, Testing and Deploying web services

### Rack

[Rack](http://rack.rubyforge.org/) is an minimal interface for developing web applications.
Rails, Sinatra, and many other web frameworks are written on top of Rack.
If you want the simplest possible web application you can use the `rack` gem
and a file named config.ru that contains the following code:

    app = lambda do |env|
      body = "Hello, World!"
      [200, {"Content-Type" => "text/plain", "Content-Length" => body.length.to_s}, [body]]
    end

    run app

To run the above application, simply use the command:

    rackup

Your application is available at http://localhost:9292 once you see something like the following in your console:

    [2011-11-08 09:06:12] INFO  WEBrick 1.3.1
    [2011-11-08 09:06:12] INFO  ruby 1.9.2 (2011-07-09) [x86_64-darwin11.1.0]
    [2011-11-08 09:06:12] INFO  WEBrick::HTTPServer#start: pid=4318 port=9292

### Rack::Test

[Rack::Test](https://github.com/brynary/rack-test) is a small, simple testing API for Rack apps.
Rack uses mock objects to allow inspection of http requests and responses without actually starting your
web application or making any client requests. Don't worry about understanding mocks right now, except to understand
it is one more trick in the ruby toolbox that makes developing and testing easier.

    # lib/my_app.rb
    require 'sinatra'
    get '/' do
      'Hello World!'
    end

    # spec/my_app_spec.rb
    require 'my_app'
    require 'rack/test'
    describe "my app" do
      include Rack::Test::Methods
      def app
        Sinatra::Application
      end

      it "should say hello" do
        # first we use rack-test to 'pretend' to make a GET request against the root of the server
        get "/"

        # rack-test creates a last_request and last_response object that we can interrogate
        last_request.env['REQUEST_METHOD'].should == 'GET'
        last_response.body.should match(/Hello World/)
        last_response.status.should == 200
      end
    end

### Heroku

[Heroku](http://www.heroku.com/) is a cloud application platform that makes deploying web
applications trivial (and free).

1. Create an account if you don’t have one
1. gem install heroku
1. Make a config.ru in the root-directory
1. Create the app on heroku
1. Push to it

[Detailed Example](https://github.com/sinatra/heroku-sinatra-app)

## Exercise

1. Use this repository to make your own, called **yourname**-week-06-sinatra
1. (optional) Add a feature and a spec for the new feature
1. Deploy the app to Heroku

## Exploration


