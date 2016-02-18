class WorkoutService
  attr_reader :workouts
  
  def initialize(current_user)
    @workouts = workouts_for(current_user)
  end

  def distance(workout)
    distance = parse(workout)['distance_total'] * (meter_to_mile)
    distance.round(2)
  end

  def average_pace(workout)
    if parse(workout)['speed_avg']
      pace = parse(workout)['speed_avg'] * (miles_per_hour_conversion)
      pace.round(2)
    else
      "N/A"
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

  def datetime(workout)
    workout["start_datetime"]
  end

  def parse(workout)
    workout['aggregates']
  end

  def meter_to_mile
    (0.00062137119)
  end

  def miles_per_hour_conversion
    (2.23694)
  end

  def metabolic_factor
    (4196)
  end

  def format_year(workout)
    datetime(workout).split("-")[0]
  end

  def format_month(workout)
    datetime(workout).split("-")[1]
  end

  def format_day(workout)
    datetime(workout)[8..9]
  end

  def format_hour(workout)
    datetime(workout).split("T")[1].split(":")[0]
  end

  def format_minute(workout)
    datetime(workout).split("T")[1].split(":")[1]
  end

  private

  def workouts_for(current_user)
    connection = Faraday.new
    connection.headers = headers
    response = connection.get(workouts_path(current_user))
    data = JSON.parse(response.body)
    data["_embedded"]["workouts"]
  end

  def workouts_path(current_user)
    "https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{current_user.user_id}"
  end

  def headers
    {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => ENV['AUTH_KEY']}
  end

end