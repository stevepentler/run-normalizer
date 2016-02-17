class WorkoutController
  def index
    binding.pry
    @workouts = MapMyRunService.new(current_user).workouts
  end

  def show
  end
end