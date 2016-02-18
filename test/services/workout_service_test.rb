class WorkoutServiceTest <ActiveSupport::TestCase
  test "#workouts" do
    VCR.use_cassette('workouts') do
      steve = users(:steve)
      workouts = WorkoutService.new.workouts_for(steve)
      binding.pry
      refute workouts.nil?
    end
  end
end