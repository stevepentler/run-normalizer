class MapMyRunService
  attr_reader :workouts
  
  def initialize(current_user)
    data = (Faraday.get('https://localhost:3000/v7.1/workout/?user=#{current_user.id}'))
    workouts = JSON.parse(data.body)
    binding.pry
  end
end