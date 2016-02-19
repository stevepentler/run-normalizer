require 'will_paginate/array'

class WorkoutsController < ApplicationController
  before_action :authorize!

  def index
    @methods = WorkoutService.new(current_user)
    @workouts = @methods.workouts_for(current_user)
                        .paginate(page: params[:page], per_page: 8)
  end

end