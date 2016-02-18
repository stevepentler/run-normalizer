module Formatter
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

  def datetime(workout)
    workout["start_datetime"]
  end
end