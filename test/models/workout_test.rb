require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  
  attr_reader :workout
  
  def setup_workout
    workout = [{"start_datetime"=>"2012-07-23T18:00:00+00:00",
                "aggregates"=>
                   {"active_time_total"=>6420.0,
                    "distance_total"=>20937.56544,
                    "steps_total"=>0.0,
                    "speed_avg"=>3.2613043232,
                    "elapsed_time_total"=>6420.0,
                    "metabolic_energy_total"=>6949624.0}}]
  end

  test "format date method" do 
    setup_workout
    assert_equal "07-23-2012", format_date(workout)
    binding.pry
  end
end
