class LectureDay < ActiveRecord::Base

	belongs_to :lecture
	belongs_to :report

	def update_report_month
		self.month_of_report = self.date_of_lecture.to_report_month
		self.save
	end

	# Los dos siguientes metodos son para update el report id en reports_controller/create

	def self.update_report_id(year, period, month, user_id, report)
		User.find(user_id).lectures.where(year: year, period: period).each do |lecture|
			 lecture.lecture_days.where(month_of_report: month).each do |day|
			 	day.update_report_id(report)
			 end
		end
	end

	def update_report_id(report)
		self.report_id = report
		self.save
	end

	# El siguiente metodo es para determinar si es un holiday

	def holiday?
		self.date_of_lecture.holiday?
	end

	# Agregar Detallitos (titi) Cuando es el dia del maestro etc. 

end

