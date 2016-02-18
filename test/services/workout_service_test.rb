class WorkoutServiceTest <ActiveSupport::TestCase
  test "#workouts" do
    VCR.use_cassette('workouts') do
      steve = users(:steve)
      binding.pry
      workouts = WorkoutService.new(steve)
      refute workouts.nil?
    end
  end
end