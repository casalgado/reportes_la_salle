class Course < ActiveRecord::Base

	has_many :lectures
	has_many :users, through: :lectures

	validates_uniqueness_of :name, scope: :program


	# este method es para load los courses como objetos en la base de datos. Deberia moverlo a un initialize.
	def self.load
		doc = Roo::Excel.new('/Users/carlosalbertosalgadohazbun/Desktop/reportes_la_salle/lib/assets/CourseLibrary.xls')
		header = doc.row(1)
			(2..59).each do |count|
				db_row = doc.row(count)
				params = Hash[header.zip db_row]
				course = Course.new(params)
				course.save
			end		
	end

end
