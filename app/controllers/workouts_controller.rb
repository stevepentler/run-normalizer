require 'will_paginate/array'

class WorkoutsController < ApplicationController
  def index
    @methods = WorkoutService.new
    @workouts = @methods.workouts_for(current_user)
                        .paginate(page: params[:page], per_page: 10)
  end

  def show
  end
end