require 'sinatra'
require 'twitter'
require 'haml'

class TwitterInfo < Sinatra::Application

  set :views, settings.root + '/../views'

  get '/' do
    '<html><body>Append a twitter username on the url to display
      how many followers the user has.<br/> For example:<br/><a href=\'/user/burtlo\'>/user/<strong>burtlo</strong></a>
      </body></html>'
  end

  get /^\/user\/(\S+)$/ do |user|

    @user = user

    user_id = Twitter.user(@user).id

    followers = Twitter.follower_ids(user_id).ids

    @num_followers = followers.length
    haml :index
  end

  post // do
    [500, nil, 'Whoa. Sorry. No POSTs allowed.']
  end

end