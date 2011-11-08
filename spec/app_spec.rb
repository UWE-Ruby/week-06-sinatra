require 'app'
require 'rspec'
require 'rack/test'

set :environment, :test

describe "Twitter Info" do
  include Rack::Test::Methods

  def app
    TwitterInfo
  end

  it "should provide instructions" do

    get "/"

    last_response.body.should match(/Append a twitter username on the url to display/)
    last_response.status.should == 200

  end

  it "should return a 500 status for any POST" do

    post "/user/burtlo"

    last_response.status.should == 500
    last_response.body.should match(/Sorry/)

  end

  it "should retrieve the user's follower count for any valid username"

end
