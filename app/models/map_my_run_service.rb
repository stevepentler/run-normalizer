class MapMyRunService
  attr_reader :connection
  
  def initialize
    faraday = Faraday.new(url: "https://oauth2-api.mapmyapi.com/v7.1/")
    faraday.headers = {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => "Bearer 258be676eee8b7b05488cc158b25ad2e6cdfd46d"}
    @connection = faraday
  end

  def workouts(current_user)
    parse(connection.get("workout/#{user_params(current_user)}"))["_embedded"]["workouts"]
  end

  private 

  def parse(response)
    JSON.parse(response.body)
  end

  def user_params(current_user)
    "?user=#{current_user.user_id}"
  end


  # attr_reader :workouts
  
  # def initialize(current_user)
  #   connection = Faraday.new
  #   connection.headers = {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => "Bearer 258be676eee8b7b05488cc158b25ad2e6cdfd46d"}
  #   response = connection.get("https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{current_user.user_id}")
  #   data = JSON.parse(response.body)
  #   @workouts = data["_embedded"]["workouts"]
  # end

  # def format_year(workout)
  #   workout["start_datetime"].split("-")[0]
  # end

  # def format_month(workout)
  #   workout["start_datetime"].split("-")[1]
  # end

  # def format_day(workout)
  #   workout["start_datetime"][8..9]
  # end

  # def format_hour(workout)
  #   workout["start_datetime"].split("T")[1].split(":")[0]
  # end

  # def format_minute(workout)
  #   workout["start_datetime"].split("T")[1].split(":")[1]
  # end

  # def distance(workout)
  #   distance = workout['aggregates']['distance_total'] * (meter_to_mile)
  #   distance.round(2)
  # end

  # def average_pace(workout)
  #   if workout['aggregates']['speed_avg']
  #     pace = workout['aggregates']['speed_avg'] * (miles_per_hour_conversion)
  #     pace.round(2)
  #   else
  #     "N/A"
  #   end
  # end

  # def meter_to_mile
  #   (0.00062137119)
  # end

  # def miles_per_hour_conversion
  #   (2.23694)
  # end

  # def duration(workout)
  #   if (workout['aggregates']['active_time_total'])
  #     total_minutes = ((workout['aggregates']['active_time_total'])*(0.01666667))
  #     hours = (total_minutes / 60).to_i
  #     minutes = (total_minutes % 60).to_i
  #     return "#{hours}:#{minutes}"
  #   else 
  #     "N/A"
  #   end
  # end

  # def metabolic_factor
  #   (4196)
  # end

  # def calories(workout)
  #   if (workout['aggregates']['metabolic_energy_total'])
  #     cals = (workout['aggregates']['metabolic_energy_total']) 
  #     kcals = (cals / metabolic_factor).to_i
  #   else
  #     "N/A"
  #   end
  # end

end