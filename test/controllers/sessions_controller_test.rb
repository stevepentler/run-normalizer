require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth(:mapmyfitness, omniauth_hash)
  end

  test "user created succesfully" do
    assert_difference('User.count(:all)') do
      post :create, provider: mapmyfitness
    end
  end
end
