class MapMyRunService
  attr_reader :workouts
  
  def initialize(current_user)
    connection = Faraday.new
    connection.headers = {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => "Bearer 258be676eee8b7b05488cc158b25ad2e6cdfd46d"}
    response = connection.get("https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{current_user.user_id}")
    data = JSON.parse(response.body)
    @workouts = data["_embedded"]["workouts"]
  end

  def format_year(workout)
    workout["start_datetime"].split("-")[0]
  end

  def format_month(workout)
    workout["start_datetime"].split("-")[1]
  end

  def format_day(workout)
    workout["start_datetime"][8..9]
  end

  def format_hour(workout)
    workout["start_datetime"].split("T")[1].split(":")[0]
  end

  def format_minute(workout)
    workout["start_datetime"].split("T")[1].split(":")[1]
  end

  def distance(workout)
    distance = workout['aggregates']['distance_total'] * (meter_to_mile)
    distance.round(2)
  end

  def meter_to_mile
    (0.00062137119)
  end
end