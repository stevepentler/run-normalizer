class WorkoutsController < ApplicationController
  def index
    @workout_methods = MapMyRunService.new(current_user)
  end

  def show
  end
end