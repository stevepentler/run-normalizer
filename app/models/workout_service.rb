class WorkoutService
  include Formatter
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

  def parse(workout)
    workout['aggregates']
  end

end