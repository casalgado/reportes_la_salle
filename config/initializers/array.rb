class Array

  def calculate_hours_per_month(month)
    hours = 0
    self.each do |lecture|
      hours += lecture.hours_in_month(month)
    end
    hours
  end

  # Returns Duplicates in an array

  def return_duplicates
  	self.find_all { |e| self.count(e) > 1 }.uniq.sort
  end

end