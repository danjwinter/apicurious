# require 'spec_helper'
# require 'rails_helper'
# require 'net/http'
#
# RSpec.feature 'External request' do
#   it 'queries FactoryGirl contributors on GitHub' do
#     uri = URI('https://api.github.com/repos/thoughtbot/factory_girl/contributors')
#
#     response = NET::HTTP.get(uri)
#
#     expect(response).to be_an_instance_of(String)
#   end
# end
