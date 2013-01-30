require 'string2hex'

class Definitions 
	def show_incoming_message(hexa,line)
		puts hexa[0]
		puts hexa[1]
		puts hexa[2]
		puts hexa[3] if line.split("#").count == 4
	end

end