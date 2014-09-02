class Lecture < ActiveRecord::Base

	belongs_to :user
	belongs_to :course
	has_many   :lecture_days, :dependent => :destroy
	
	# Los siguientes 3 methods generan los lecture days

	def first_day_of_lecture
		yday = 12  if self.period == 1
		yday = 124 if self.period == 2
		yday = 243 if self.period == 3
		first_day_of_lecture = Date.ordinal(self.year, yday)
		first_day_of_lecture
	end

	def last_day_of_lecture
		yday = 115  if self.period == 1
		yday = 227  if self.period == 2
		yday = 346  if self.period == 3
		last_day_of_lecture = Date.ordinal(self.year, yday)
		last_day_of_lecture
	end

	def generate_lecture_days
		start = self.first_day_of_lecture
		until start >= self.last_day_of_lecture
			if start.wday == self.week_day
				day = LectureDay.new(:lecture_id => self.id, :date_of_lecture => start, :time_of_lecture => self.lecture_start_time, :month_of_report => start.to_report_month)
				day.save
				start += 6
			end
			start += 1
		end
	end

	# Este metodo es para actualizar los LDays cuando la lecture ha sido editada. 

	def update_lecture_days
		self.lecture_days.each do |day| day.destroy end
		self.generate_lecture_days
	end


	# Calcula el numero de horas dictadas de esta clase en el mes "month".
	def hours_in_month(month)
		self.lecture_days.where(:month_of_report => month).count * self.course.duration
	end

	# Filtra Lectures en LecturesController/index.

	def self.per_period_program(period, program)
		Lecture.where(:course_id => [Course.where(:program_id => program).map(&:id)], :period => period, year: Date.today.year)
	end

	def self.per_period_program_semester(period, program, semester)
		Lecture.where(:period => period, year: Date.today.year, :course_id => [Course.where(:program_id => program, :semester => semester).map(&:id)])
		
	end

end
