def bisection(absolute_tolerance, lower_bound, upper_bound, function)
	abort "Root not bracketed!" if (send(function, lower_bound) * send(function, upper_bound)) > 0
	if send(function, lower_bound) > 0
		temp_lower_bound = lower_bound
		lower_bound = upper_bound
		upper_bound = temp_lower_bound
	end
  dx = upper_bound - lower_bound
 	new_y = 1 + absolute_tolerance
 	number_of_iterations = 0
 	until new_y.abs < absolute_tolerance
 		dx /= 2
 		new_y = send(function, lower_bound + dx)
 		if new_y < 0
 			lower_bound += dx
 		end
 		number_of_iterations += 1
 	end
 	print_conclusion(new_y, lower_bound + dx, number_of_iterations)
end


def secant(absolute_tolerance, lower_bound, upper_bound, function)
	old_y = send(function, lower_bound)
	new_y = send(function, upper_bound)
	number_of_iterations = 0
	until new_y.abs < absolute_tolerance
		dx = (lower_bound - upper_bound) * new_y / (new_y - old_y)
		lower_bound = upper_bound
		old_y = new_y
		upper_bound += dx
		new_y = send(function, upper_bound)
		number_of_iterations += 1
	end
	print_conclusion(new_y, upper_bound, number_of_iterations)
end

def false_position(absolute_tolerance, lower_bound, upper_bound, function)
	number_of_iterations = 0
	old_y = send(function, lower_bound)
	new_y = send(function, upper_bound)
	abort "Root not bracketed!" if old_y * new_y > 0
	if old_y > 0
		temp_lower_bound = lower_bound
		lower_bound = upper_bound 	
		upper_bound = temp_lower_bound
		temp_old_y = old_y
		old_y = new_y
		new_y = temp_old_y	
	end
	new_val = 1 + absolute_tolerance
	until new_val.abs < absolute_tolerance
		new_x = lower_bound + (upper_bound - lower_bound) * old_y / (old_y - new_y)
		new_val = send(function, new_x) 
		if send(function, new_x) < 0
			lower_bound = new_x
			old_y = new_val
		else
			upper_bound = new_x
			new_y = new_val
		end
		number_of_iterations += 1
	end
	print_conclusion(new_val, new_x, number_of_iterations)
end

def fourthroottwo(x)
	return x**4 - 2
end

def print_conclusion(final_y, final_x, number_of_iterations)
	puts "Final y value: #{final_y}"
	puts "Final x value: #{final_x}"
	puts "Number of iterations: #{number_of_iterations}"
end
#Here's where the stuff starts when you run the program

functions = ["fourthroottwo"]
methods = ["bisection", "secant", "false_position", "fpi"]

puts "Select a function from the following: "

functions.each_with_index do |function, index|
	puts "For #{function} function enter #{index}"
end

selected_function = functions[gets.chomp.to_i] 

puts "Select a method from the following: "

methods.each_with_index do |method, index|
	puts "For #{method} method enter #{index}"
end

selected_method = methods[gets.chomp.to_i]

puts "Enter absolute_tolerance: "

absolute_tolerance = gets.chomp.to_f

puts "Enter lower bound: "

lower_bound = gets.chomp.to_f

puts "Enter upper bound: "

upper_bound = gets.chomp.to_f

send(selected_method, absolute_tolerance, lower_bound, upper_bound, selected_function)

