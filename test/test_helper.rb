ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock'
require 'vcr'
require 'minitest-vcr'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  config.include Capybara::DSL

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.allow_http_connections_when_no_cassette = true
  end
  
  MinitestVcr::Spec.configure!

  OmniAuth.config.test_mode = true
  omniauth_hash = 
{"provider"=>"mapmyfitness",
 "info"=>
  {"weight"=>78.01788764,
   "height"=>1.8542,
   "id"=>8695588,
   "display_name"=>"steven pentler",
   "location"=>{"country"=>"US", "region"=>"WI", "locality"=>"Brookfield", "address"=>""},
   "email"=>"stevepentler@gmail.com",
   "username"=>"pentler",
   "gender"=>"M",
   "birthdate"=>"1991-05-23",
 "credentials"=>{"token"=>"258be676eee8b7b05488cc158b25ad2e6cdfd46d", "refresh_token"=>"2bab757e1a9fec3586161df37cdd8cc866688737", "expires_at"=>1460520194, "expires"=>true}
  }
}


  OmniAuth.config.add_mock(:mapmyfitness, omniauth_hash)
end
