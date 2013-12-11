require 'octokit'
token = ENV['GITHUB_TOKEN']

stack = Faraday::Builder.new do |builder|
  builder.response :logger
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack

client = Octokit::Client.new(access_token: token)
client.configure do |config|
  config.per_page = 16
  config.auto_paginate = false
end

p client.organization_members('Shopify', per_page: 16, auto_paginate: false).count

#followers = client.followers.map(&:login)
#p followers
#p followers.count

#p client.organizations.map(&:login)
#each do |org|
#p  org.login
#end

#client.organization_members('Shopify', :per_page => 20).each do |member|
#  login = member.login
#  unless client.follows?(login)
#    if client.follow(login)
#      p "Following #{login}"
#    end
#  end
#end
