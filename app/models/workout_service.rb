class WorkoutService
  include Formatter
  attr_reader :connection
  
  # def initialize(current_user)
  #   @workouts = workouts_for(current_user)
  # end

  def distance(workout)
    distance = parse(workout)['distance_total'] * (meter_to_mile)
    distance.round(2)
  end

  def average_speed(workout)
    if parse(workout)['speed_avg']
      pace = parse(workout)['speed_avg'] * (miles_per_hour_conversion)
      pace.round(2)
    else
      "N/A"
    end
  end

  def average_pace(workout)
    if average_speed(workout) == "N/A"
      "N/A"
    else
      minutes = (60.0 / average_speed(workout)).to_i
      seconds = ((60.0 / average_speed(workout) - minutes) * 60).to_i
      format_pace(minutes, seconds)
    end
  end

  def duration(workout)
    if parse(workout)['active_time_total']
      total_minutes = (parse(workout)['active_time_total'])*(0.01666667)
      hours = (total_minutes / 60).to_i
      minutes = (total_minutes % 60).to_i
      return "#{hours}hr #{minutes}mins"
    else 
      "N/A"
    end
  end

  def calories(workout)
    if (parse(workout)['metabolic_energy_total'])
      calories = (parse(workout)['metabolic_energy_total']) 
      kcals = (calories / metabolic_factor).to_i
    else
      "N/A"
    end
  end

  def workouts_for(current_user)
    connection = Faraday.new
    connection.headers = headers
    response = connection.get(workouts_path(current_user))
    data = JSON.parse(response.body)
    data["_embedded"]["workouts"]
  end

  def initialize
    connection = Faraday.new("https://oauth2-api.mapmyapi.com/v7.1/workout") do |faraday|
      faraday.headers = headers
      faraday.adapter Faraday.default_adapter
    end
  end

  def workouts_path(current_user)
    JSON.parse(connection.get("/?user=#{current_user.user_id}"))
    # "https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{current_user.user_id}"
  end

#   def add_workout
#     connection = Faraday.new
#     connection.headers = headers
#     response = connection.post(add_workout_path)
#     data = JSON.parse(response.body)
#   end

# #refactor with optional argument
#   def add_workout_path
#     "https://oauth2-api.mapmyapi.com/v7.1/workout/"
#   end

  def headers
    {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => ENV['AUTH_KEY']}
  end

  def parse(workout)
    workout['aggregates']
  end

end