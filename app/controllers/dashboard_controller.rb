class DashboardController < ApplicationController
  def show
    @workouts = MapMyRunService.new(current_user).workouts
  end
end