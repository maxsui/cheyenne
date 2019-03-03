class DayTime

  attr_accessor :hour, :minute

  def initialize(hour, minute)
    @hour, @minute = hour, minute
  end

  alias_method :min, :minute

  def self.from_time_helper(_, _, hour, minute, _)
    new hour, minute
  end

  def self.null_method(*names)
    names.each do |name|
      define_method name do
        nil
      end
    end
  end
  null_method :day, :month, :year

  def <=>(other)
    hour_comparaison = hour <=> other.hour

    if hour_comparaison == 0
      minute <=> other.minute
    else
      hour_comparaison
    end
  end

end
