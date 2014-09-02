class Course < ActiveRecord::Base

	has_many :lectures
	has_many :users, through: :lectures
	belongs_to :program

	validates_uniqueness_of :name, scope: :program_id


	# Este method es para load los courses como objetos en la base de datos.
	
	def self.load
		doc = Roo::Excel.new(Rails.root.join('lib/assets/CourseLibrary.xls').to_s)
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
      Course.where(:program_id => program)
    else
      Course.where(:program_id => program, :semester => semester)
    end
	end

end

