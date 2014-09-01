class Holiday < ActiveRecord::Base

	def self.load
		years = ['2014-','2015-','2016-','2017-','2018-','2019-','2020-','2021-','2022-', '2023-', '2024-']
		
		flexible_holidays = ["01-06", "03-19", "06-29", "08-15", "10-12", "11-01", "11-11"]
		fixed_holidays = ["01-01", "05-01", "07-20", "08-07", "12-08", "12-25"]
		religious_fix_holidays = [-48, -47, -3, -2] 
		religious_flex_holidays = [39, 60, 68]

			years.each do |year|
				easter = WhenEaster::EasterCalendar.find_roman_easter_date(year.to_i).to_date

				fixed_holidays.each do |fix|
					date = Date.parse(year+fix)
						Holiday.new(:date => date).save

					end

				flexible_holidays.each do |flex|
					date = Date.parse(year+flex)
						Holiday.new(:date => date.move_holiday).save
					end
						
				religious_fix_holidays.each do |rfix|
					date = easter + rfix
						Holiday.new(:date => date).save
				end

				religious_flex_holidays.each do |rflex|
					date = easter + rflex
						Holiday.new(:date => date.move_holiday).save
				end

			end
	end


end



