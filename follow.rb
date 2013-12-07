require 'octokit'

token = ENV['GITHUB_TOKEN']
client = Octokit::Client.new :access_token => token

p client.organizations.map(&:login)

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
