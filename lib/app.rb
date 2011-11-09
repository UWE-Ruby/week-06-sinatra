require 'sinatra'
require 'twitter'
require 'haml'

class TwitterInfo < Sinatra::Application

  set :views, settings.root + '/../views'

  get '/' do
    haml :index
  end

  get '/user/:username' do

    @user = params[:username]
    user_id = Twitter.user(@user).id
    followers = Twitter.follower_ids(user_id).ids
    @num_followers = followers.length

    haml :followers

  end

  post // do
    halt 500, 'Whoa. Sorry. No POSTs allowed.'
  end

end