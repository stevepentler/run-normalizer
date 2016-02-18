require 'will_paginate/array'

class WorkoutsController < ApplicationController
  def index
    @methods = WorkoutService.new(current_user)
    @workouts = @methods.workouts
                        .paginate(page: params[:page], per_page: 10)
  end

  def show
  end
end