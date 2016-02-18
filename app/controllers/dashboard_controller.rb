class DashboardController < ApplicationController
  def show
    @methods = AggregateDataService.new(current_user)
    @aggregate_data = AggregateDataService.new(current_user).aggregate_data_for(current_user)
  end
end