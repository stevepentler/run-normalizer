require 'test_helper'

class UserSessionsTest < ActionDispatch::IntegrationTest
  def setup
    OmniAuth.config.mock_auth[:mapmyfitness]
  end

  test "Succesful User Login" do
    user = users(:steve)
    
    visit root_path
    click_on "Login with Map My Fitness"
    
    visit dashboard_path
    assert page.has_content?(user.username)
    assert page.has_content?(user.email)
    assert page.has_content?("View Workouts")
    assert page.has_content?("miles")
    assert page.has_content?("calories")
    assert page.has_content?("steps")
    assert page.has_content?("sessions")

    click_on "View Workouts"
    assert_equal workouts_path, current_path

    assert page.has_content?(user.username)
    assert page.has_content?("Workouts")
    assert page.has_content?("Date")
    assert page.has_content?("Started At")
    assert page.has_content?("Distance")
    assert page.has_content?("Duration")
    assert page.has_content?("Avg-Speed")
    assert page.has_content?("Avg-Pace")
    assert page.has_content?("Calories")
  end

  test "Succesful User Logout" do
    user = users(:steve)
    
    visit root_path
    click_on "Login with Map My Fitness"
    
    visit dashboard_path
    assert page.has_content?(user.username)
    assert page.has_content?(user.email)

    click_on "View Workouts"
    assert_equal workouts_path, current_path
    assert page.has_content?(user.username)

    click_on "Dashboard"
    assert_equal dashboard_path, current_path

    click_on "Logout"
    assert_equal root_path, current_path
  end

end
