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
If you want the simplest possible web application you can use the rack gem
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

Sinatra uses rack, so this is a rack application.

    # lib/my_app.rb
    require 'sinatra'
    get '/' do
      'Hello World!'
    end

Our spec file simply includes our code and rack/test, and then provides some required set-up.

    # spec/my_app_spec.rb
    require 'my_app'
    require 'rack/test'

    describe "my app" do
      include Rack::Test::Methods

      def app
        Sinatra::Application
      end

      ...
    end

In the spec file's examples we use rack-test to simulate, or mock, a GET request against the server.
**Note:** the `get` method used here is from rack-test, not sinatra!

      get "/"

The rack-test code then creates `last_request` and `last_response` objects that we can interrogate.

    last_request.env['REQUEST_METHOD'].should == 'GET'
    last_response.body.should match(/Hello World/)
    last_response.status.should == 200

### Heroku

[Heroku](http://www.heroku.com/) is a cloud application platform that makes deploying web
applications trivial (and free).

1. [Create a Heroku account](https://api.heroku.com/signup)
1. Install the heroku gem with `gem install heroku`
1. Make a config.ru in the root-directory that runs your app
1. Create the app on heroku with `heroku create <your-appname>`
1. Push to it heroku with `git push heroku master`
1. Open the app in a browser at http://**your-heroku-app-name**.heroku.com or type `heroku open`

[Example](https://github.com/sinatra/heroku-sinatra-app)

## Exercise

Review the sinatra [documentation](http://www.sinatrarb.com/intro.html).

1. Use this repository to make your own, called **yourname**-week-06-sinatra .
1. Complete the two pending specs. One of them describes a feature that you will need to write.
1. (optional) Add yet another feature and a spec for it.
1. Deploy the app to Heroku.

## Exploration

### [Travis CI](http://about.travis-ci.org/docs/user/getting-started/)
A distributed build system for the open source community.

This service automatically runs your tests everytime you push your code to github.
While you should always run your tests manually before you commit, this continuous integration service
can be very useful when you have long running tests and/or many contributors.

In order to build your Ruby project on Travis CI, your repository should have a
Rakefile with the default task being a test task.

As well, Travis makes it easy to test your project against multiple versions and flavors of Ruby.
Take a look at the file named `.travis.yml` in this project and notice the flavors of ruby that will be used to run tests.

Once you have that set up, you can include your live build status in your Readme file, like so:
[![build status](http://travis-ci.org/bfaloona/week-06-sinatra.png)](http://travis-ci.org/bfaloona/week-06-sinatra)




