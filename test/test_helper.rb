ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock'
require 'vcr'
require 'minitest-vcr'
require 'capybara/rails'

class ActiveSupport::TestCase
  class ActionDispatch::IntegrationTest
    include Capybara::DSL
  end
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.allow_http_connections_when_no_cassette = true
  end
  
  MinitestVcr::Spec.configure!

  OmniAuth.config.test_mode = true
  omniauth_hash = 
{"provider"=>"mapmyfitness",
 "uid"=>nil,
 "info"=>
  {"last_name"=>"pentler",
   "weight"=>78.01788764,
   "height"=>1.8542,
   "hobbies"=>"",
   "id"=>8695588,
   "date_joined"=>"2011-08-08T21:24:11+00:00",
   "first_name"=>"steven",
   "display_name"=>"steven pentler",
   "introduction"=>"",
   "display_measurement_system"=>"imperial",
   "last_login"=>"2014-02-18T16:14:33+00:00",
   "location"=>{"country"=>"US", "region"=>"WI", "locality"=>"Brookfield", "address"=>""},
   "email"=>"stevepentler@gmail.com",
   "username"=>"pentler",
   "sharing"=>{"twitter"=>false, "facebook"=>false},
   "gender"=>"M",
   "time_zone"=>"America/Denver",
   "birthdate"=>"1991-05-23",
   "profile_statement"=>""},
 "credentials"=>{"token"=>"258be676eee8b7b05488cc158b25ad2e6cdfd46d", "refresh_token"=>"2bab757e1a9fec3586161df37cdd8cc866688737", "expires_at"=>1460520194, "expires"=>true},
 "extra"=>{}}

  OmniAuth.config.add_mock(:mapmyfitness, omniauth_hash)
end
