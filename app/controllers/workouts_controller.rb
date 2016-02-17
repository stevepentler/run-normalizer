class WorkoutsController < ApplicationController
  before_action :current_user
  # def initialize
  #   faraday = Faraday.new(url: "https://oauth2-api.mapmyapi.com/v7.1/")
  #   faraday.headers = {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => "Bearer 258be676eee8b7b05488cc158b25ad2e6cdfd46d"}
  #   @connection = faraday
  # end

  def index
    @workout_methods = Workout.all(current_user)
    binding.pry
  end

  # def workouts
  #   parse(connection.get("workout/#{user_params}"))["_embedded"]["workouts"]
  # end

  def show
  end

  private

  def current_user
    current_user = current_user
  end

  # private 

  # def parse(response)
  #   JSON.parse(response.body)
  # end

  # def user_params
  #   "?user=#{current_user.user_id}"
  # end
end