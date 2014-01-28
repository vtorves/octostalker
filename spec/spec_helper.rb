ENV['RACK_ENV'] = 'test'

require './octostalker'
require 'rspec'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'webmock/rspec'

OmniAuth.config.test_mode = true
WebMock.disable_net_connect!(allow_localhost: true)

Capybara.configure do |config|
  config.app = OctostalkerApplication
  config.javascript_driver = :poltergeist
  config.default_driver = :poltergeist
end

module GitHubHelpers
  def mock_auth
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: 'github',
      uid: 1,
      extra: {
        raw_info: {
          avatar_url: 'http://www.gravatar.com/avatar/bd33b5aaf0eb48d67a8145732d8f61a9.png'
        }
      },
      credentials: {
        :token => 'token'
      })
  end

  def mock_invalid_auth
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  end

  def stub_orgs(json = [])
    stub_request(:get, "https://api.github.com/user/orgs").
      to_return(:status => 200, :body => json.to_json, :headers => {'Content-Type' => 'application/json'})
  end

  def stub_user
    stub_request(:get, "https://api.github.com/user").
      to_return(:status => 200, :body => "{}", :headers => {'Content-Type' => 'application/json'})
  end

  def stub_followers(json = [])
    stub_request(:get, "https://api.github.com/users/followers?auto_paginate=false&per_page=16").
      to_return(:status => 200, :body => json.to_json, :headers => {'Content-Type' => 'application/json'})
  end

  def app
    OctostalkerApplication
  end

  def signin
    visit '/'
    mock_auth
    stub_user
    stub_followers
    stub_orgs
    click_link 'Signin with GitHub'
  end
end

RSpec.configure do |config|
  include Rack::Test::Methods
  include GitHubHelpers
end
