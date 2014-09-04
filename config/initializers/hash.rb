class Hash

	def courses_per_area(program)
		total = program.courses.count
		self.values.collect {|x| "#{(x*100)/total}%"}.join('|')
	end



end