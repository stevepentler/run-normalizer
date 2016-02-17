class WorkoutsController < ApplicationController
  def index
    @methods = WorkoutService.new(current_user)
    @workouts = @methods.workouts
  end

  def show
  end
end