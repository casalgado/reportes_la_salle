class Integer

  def period_to_report_month
  	if self == 1
  		1
  	elsif self == 2
  		5
  	else
  		9
  	end
  end

end