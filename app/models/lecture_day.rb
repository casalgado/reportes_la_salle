class LectureDay < ActiveRecord::Base

	belongs_to :lecture
	belongs_to :report

	def update_report_month
		self.month_of_report = self.date_of_lecture.to_report_month
		self.save
	end

end

