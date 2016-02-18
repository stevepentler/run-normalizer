class AggregateDataService
  include Formatter
  # attr_reader :aggregate_data
  
  # def initialize(current_user)
  #   @aggregate_data = aggregate_data_for(current_user)
  # end

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

  # attr_reader :aggregate_data
  
  # def initialize(current_user)
  #   @aggregate_data = aggregate_data_for(current_user)
  # end

  attr_reader :connection, :aggregate_data

    def initialize(current_user)
      @connection = Faraday.new("https://oauth2-api.mapmyapi.com/v7.1/") do |faraday|
        faraday.headers = headers
        faraday.adapter Faraday.default_adapter
      end
      @aggregate_data = aggregate_data_for(current_user)
    end

  def aggregate_data_for(current_user)
    response = connection.get(aggregate_data_path(current_user))
    data = JSON.parse(response.body)
  end

  def aggregate_data_path(current_user)
    "aggregate/?data_types=distance_summary%2C+energy_expended_summary%2C+steps_summary%2C+sessions_summary&end_datetime=2020-05-05&period=P1D&start_datetime=2000-05-05&user_id=#{current_user.user_id}"
  end

  def headers
    {"User-Agent"=>"Faraday v0.9.2", "Api-Key" => ENV['MMF_API_KEY'], "Authorization" => ENV['AUTH_KEY']}
  end

end