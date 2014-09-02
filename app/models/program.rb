class Program < ActiveRecord::Base

	has_many :courses
	has_many :lectures, through: :courses

	# Este metodo es para load los programs a la base de datos.

	def self.load

		program_params = [ {name: 'Grafico',      semesters: 6}, 
			                 {name: 'Interiorismo', semesters: 7}, 
			                 {name: 'Fotografia',   semesters: 6},
			                 {name: 'Mercadeo',     semesters: 7},
			                 {name: 'Modas',        semesters: 7} ]

		program_params.each do |hash|
			program = Program.new(hash)
			program.save
		end					
	end

	# Este es para crear el array que se usa en lectures/new

	def semester_array
		array = []
		(1..self.semesters).each do |integer|
			array << integer
		end
		array
	end

end
