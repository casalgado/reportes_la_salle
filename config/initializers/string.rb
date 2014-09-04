class String

	# Returns los programas a los que la asignatura pertenece

	def belongs_to_programs
			Course.where(:name => self).collect {|x| x.program }
	end

end