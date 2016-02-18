ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  OmniAuth.config.test_mode = true
  omniauth_hash = { 'provider' => 'mapmyfitness',
                    'user_id'  => ENV['USER_ID'],
                    'info' => {
                        'email' => ENV['USER_EMAIL'],
                        'username' => 'pentler',
                        'display_name' => 'steven pentler'
                    }
  }

  OmniAuth.config.add_mock(:mapmyfitness, omniauth_hash)
end
