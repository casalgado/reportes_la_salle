class Lecture < ActiveRecord::Base

	belongs_to :user
	belongs_to :course
	has_many   :lecture_days
	
	# para encontrar el name del course en views/lectures/my_lectures
	def course_name
		@course_name = Course.find(self.course_id).name
	end

	# los siguientes 3 methods son para generar los lecture days
	def first_day_of_lecture
		yday = 12  if self.period == 1
		yday = 124 if self.period == 2
		yday = 243 if self.period == 3
		@first_day_of_lecture = Date.ordinal(self.year, yday)
		@first_day_of_lecture
	end

	def last_day_of_lecture
		yday = 115  if self.period == 1
		yday = 227  if self.period == 2
		yday = 346  if self.period == 3
		@last_day_of_lecture = Date.ordinal(self.year, yday)
		@last_day_of_lecture
	end

	def generate_lecture_days
		start = self.first_day_of_lecture
		until start === self.last_day_of_lecture
			if start.wday == self.week_day
				day = LectureDay.new(:lecture_id => self.id, :date_of_lecture => start, :time_of_lecture => self.lecture_start_time, :month_of_report => start.to_report_month)
				day.save
			end
			start += 1
		end
	end

	# para calcular el numero de horas dictadas de esta clase en el mes "month"
	def hours_in_month(month)
		self.lecture_days.where(:month_of_report => month).count * Course.find(self.course_id).duration
	end

end
