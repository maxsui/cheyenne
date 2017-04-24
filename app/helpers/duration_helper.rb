module DurationHelper
  def human_duration(duration)
    hours = duration / 3600
    minutes = duration % 3600 / 60

    "#{hours.to_i} h".tap do |s|
      s << " #{minutes.to_i}" if minutes > 0
    end
  end
end
