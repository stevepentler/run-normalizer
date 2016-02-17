class MapMyRunService
  attr_reader :workouts
  
  def initialize(current_user)
    connection = Faraday.new
    connection.headers = {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => "Bearer 258be676eee8b7b05488cc158b25ad2e6cdfd46d"}
    response = connection.get("https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{current_user.user_id}")
    data = JSON.parse(response.body)
    @workouts = data["_embedded"]["workouts"]
  end
end