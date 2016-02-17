class WorkoutsController < ApplicationController
  def index
    @methods = MapMyRunService.new(current_user)
    @workouts = MapMyRunService.new(current_user).workouts
  end

  def show
  end
end