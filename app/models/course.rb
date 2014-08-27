class Course < ActiveRecord::Base

	has_many :lectures
	has_many :users, through: :lectures

	validates_uniqueness_of :name, scope: :program


	# Este method es para load los courses como objetos en la base de datos. Deberia moverlo a un initialize.
	def self.load
		doc = Roo::Excel.new('/Users/carlosalbertosalgadohazbun/Desktop/reportes_la_salle/lib/assets/CourseLibrary.xls')
		header = doc.row(1)
			(2..100).each do |count|
				db_row = doc.row(count)
				params = Hash[header.zip db_row]
				course = Course.new(params)
				course.save
			end		
	end

	# Este metodo es para LecturesController/new 

	def self.filter_courses(program, semester)
		if program == nil
      Course.all
    elsif semester == nil
      Course.where(:program => program)
    else
      Course.where(:program => program, :semester => semester)
    end
	end

end
