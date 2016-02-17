class DashboardController < ApplicationController
  def show
    @aggregate_data = AggregateDataService.new(current_user)
  end
end