class Report < ActiveRecord::Base

	acts_as_xlsx
	belongs_to :user
	has_many :lecture_days

	validates_uniqueness_of :user_id, :scope => [:year, :month_of_report]

	# Para contar el numero de Reports entregados en un mes dado.

	def self.reports_turned_in_count(month)
		Report.where(year: Date.today.year.to_i, month_of_report: month).count
	end

	# Devuelve un array con los id's de los users que han entregado reporte en ese mes.

	def self.reports_turned_in_users(month)
		Report.where(year: Date.today.year.to_i, month_of_report: month).select(:user_id).map(&:user_id)
	end

	# Si existe el report para un determinado mes

	def self.exists_for?(id, lecture_day)
		Report.where(:user_id => id, :month_of_report => lecture_day.date_of_lecture.to_report_month).empty?
	end

	# Calcula el periodo del report tomando como parametro el mes

	def period
		if self.month_of_report > 8
			3
		elsif self.month_of_report < 5
			1
		else
			2
		end
	end



end
