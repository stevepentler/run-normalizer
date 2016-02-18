ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock'
require 'vcr'
require 'minitest-vcr'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.allow_http_connections_when_no_cassette = true
  end
  
  MinitestVcr::Spec.configure!

  # OmniAuth.config.test_mode = true
  # omniauth_hash = { 'provider' => 'mapmyfitness',
  #                   'user_id'  => ENV['USER_ID'],
  #                   'info' => {
  #                       'email' => ENV['USER_EMAIL'],
  #                       'username' => 'pentler',
  #                       'display_name' => 'steven pentler'
  #                   }
  # }

  # OmniAuth.config.add_mock(:mapmyfitness, omniauth_hash)
end
