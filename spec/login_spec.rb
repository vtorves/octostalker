require 'spec_helper'

describe 'Logging', :type => :feature, :css => true do
  subject { page }

  context 'when credentials are invalid' do

    before do
      visit '/'
      mock_invalid_auth
      click_link 'Signin with GitHub'
    end

    it "sends back to homepage" do
      expect(current_path).to eq('/')
    end

    it "has a error message" do
      expect(find('#msg.error')).to be_visible
    end
  end

  context 'when credentials are valid' do

    before do
      visit '/'
      mock_auth

      stub_user
      stub_followers
      stub_orgs
      click_link 'Signin with GitHub'
    end

    it "sends back to homepage" do
      expect(current_path).to eq('/')
    end

    it "shows the logout button" do
      expect(find_link('Logout')).to be_visible
    end
  end
end
