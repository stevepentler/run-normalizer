class Workout < ActiveRecord::Base
  belongs_to :user

  @workouts = MapMyRunService.new(current_user)

  def format_date(workouts)
    binding.pry
    
  end
end
