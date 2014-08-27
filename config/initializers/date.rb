class Date

  def to_report_month
    if self.mday < 26
    	self.mon
    else
    	self.mon + 1
    end
  end

  def to_period
  	if self.yday < 123
  		'1'
  	elsif self.yday > 242
  		'3'
  	else
  		'2'
  	end	
  end

  def move_holiday
    if self.wday == 1
      self
    elsif self.wday == 0
      Date.ordinal(self.year, (self.yday + 1))
    else 
      Date.ordinal(self.year, (self.yday + (8-self.wday)))
    end
  end

  def holiday?
    unless Holiday.where(:date => self).empty?
      true
    else
      false
    end 
  end


end