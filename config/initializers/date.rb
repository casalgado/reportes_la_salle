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


end