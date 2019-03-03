class SeanceUpdate
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment

  attr_accessor :date, :time, :duration
  attr_accessor :enable_scheduling

  alias_method :enable_scheduling?, :enable_scheduling

  def seance
    @seance ||= Seance.new
  end
  delegate :persisted?, to: :seance

  def assign_attributes(new_attributes)
    date_attribute_keys = (1..3).map { |n| "date(#{n}i)".to_sym }
    time_attribute_keys = (1..5).map { |n| "time(#{n}i)" }

    date_attributes = new_attributes.values_at(*date_attribute_keys).compact
    date = date_attributes.present? ? Date.new(*date_attributes.map(&:to_i)) : nil

    time_attributes = new_attributes.values_at(*time_attribute_keys).compact
    Rails.logger.debug "time_attributes: #{time_attributes.inspect}"
    time = time_attributes.present? ? DayTime.from_time_helper(*time_attributes.map(&:to_i)) : nil

    processed_attribute_keys = date_attribute_keys + time_attribute_keys
    rewrited_attributes = new_attributes.except(*processed_attribute_keys).merge(date: date, time: time)

    Rails.logger.debug "rewrited_attributes: #{rewrited_attributes.inspect}"

    super rewrited_attributes
  end

  def seance_attributes=(attributes)
    seance.attributes = attributes
  end

  def scheduling
    seance.scheduling ||= Scheduling.new
  end

  def scheduling_attributes=(attributes)
    scheduling.attributes = attributes
  end

  def class_for_attribute(attr)
    Rails.logger.debug attr.inspect
    { "date" => Date, "time" => DayTime }[attr]
  end

  def seance_id
    seance&.id
  end

  def save
    Rails.logger.debug "Seance update: #{inspect}"
    return false
  end

end
