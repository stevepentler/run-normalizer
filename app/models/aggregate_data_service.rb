class AggregateDataService
  attr_reader :aggregate_data
  
  def initialize(current_user)
    connection = Faraday.new
    connection.headers = {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => ENV['AUTH_KEY']}
    response = connection.get("https://oauth2-api.mapmyapi.com/v7.1/aggregate/?data_types=distance_summary%2C+energy_expended_summary%2C+steps_summary%2C+sessions_summary&end_datetime=2020-05-05&period=P1D&start_datetime=2000-05-05&user_id=#{current_user.user_id}")
    data = JSON.parse(response.body)
    @aggregate_data = data
  end

  def aggregate_distance
    meters = parser(0, "distance_sum")
    miles = (meters * meter_to_mile).to_i
  end

  def aggregate_calories
    calories = parser(1, "energy_expended_sum")
    kcals = (calories / metabolic_factor).to_i
  end

  def aggregate_steps
    sessions = parser(2, "steps_sum")
  end

  def aggregate_sessions
    sessions = parser(3, "sessions_sum")
  end

  def parser(element, category)
    aggregate_data["_embedded"]["aggregates"][element]["summary"]["value"][category]
  end

  def meter_to_mile
    (0.00062137119)
  end

  def metabolic_factor
    (4196)
  end

end