class DashboardController < ApplicationController
  before_action :authorize!
  
  def show
    @methods = AggregateDataService.new(current_user)
    @aggregate_data = @methods.aggregate_data_for(current_user)
  end
end