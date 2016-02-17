class Workout 

  def self.service
    MapMyRunService.new
  end

  def self.all(current_user)
    service.workouts(current_user)
    binding.pry
  end
end
