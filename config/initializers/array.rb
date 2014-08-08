class Array

  def calculate_hours_per_month(month)
    hours = 0
    self.each do |lecture|
      hours += lecture.hours_in_month(month)
    end
    hours
  end


end