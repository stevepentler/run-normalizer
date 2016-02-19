class WorkoutServiceTest <ActiveSupport::TestCase
  test "#workouts" do
    VCR.use_cassette('workouts') do
      steve = users(:steve)
      methods = WorkoutService.new
      workout = methods.workouts_for(steve).first

      assert_equal "2012-08-06T16:25:04+00:00", workout["created_datetime"]
      assert_equal "8:13", methods.average_pace(workout)
      assert_equal 13.01, methods.distance(workout)
      assert_equal "1hr 47mins", methods.duration(workout)
      assert_equal 7.3, methods.average_speed(workout)
      assert_equal 1656, methods.calories(workout)
    end
  end
end