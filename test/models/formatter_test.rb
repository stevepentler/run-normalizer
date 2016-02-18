require 'test_helper'

class FormatterTest <ActiveSupport::TestCase
  include Formatter

  def workout
    {"start_datetime"=>"2012-09-19T13:31:41+00:00",
     "name"=>"A 9.98 mi run mapped on Wed Sep 19 2012",
     "aggregates"=>
      {"active_time_total"=>9480.0, "distance_total"=>32146.3245312, "steps_total"=>0.0, "speed_avg"=>3.3909625033, "elapsed_time_total"=>9480.0, "metabolic_energy_total"=>5656768.0}}
  end

  test "conversion factors" do 
    assert_equal (0.00062137119), meter_to_mile
    assert_equal (2.23694), miles_per_hour_conversion
    assert_equal (4196), metabolic_factor
  end

  test "pace formatter" do
    assert_equal "7:05", format_pace(7, 5)
    assert_equal "7:10", format_pace(7, 10)
  end

  test "datetime formatter" do
    assert_equal "2012-09-19T13:31:41+00:00", datetime(workout)
    assert_equal "2012", format_year(workout)
    assert_equal "09", format_month(workout)
    assert_equal "19", format_day(workout)
    assert_equal "13", format_hour(workout)
    assert_equal "31", format_minute(workout)
  end

end