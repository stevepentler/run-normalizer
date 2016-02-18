class AggregateDataServiceTest <ActiveSupport::TestCase
  test "#data" do
    VCR.use_cassette('aggregate_data') do
      steve = users(:steve)
      methods = AggregateDataService.new(steve)

      assert_equal 805, methods.aggregate_distance
      assert_equal 86683, methods.aggregate_calories
      assert_equal 1567114, methods.aggregate_steps
      assert_equal 106, methods.aggregate_sessions
    end
  end
end