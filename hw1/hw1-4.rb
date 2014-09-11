def bisection(absolute_tolerance, lower_bound, upper_bound, function)
	if (send(function, lower_bound) * send(function, upper_bound)) > 0
		puts "Root not bracketed!"
	end
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
 	puts "Final y value: #{new_y}"
 	puts "Final x value: #{lower_bound + dx}"
 	puts "Number of iterations: #{number_of_iterations}"
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
	puts "Final y value: #{new_y}"
	puts "Final x value: #{upper_bound}"
	puts "Number of iterations: #{number_of_iterations}"
end

def false_position(absolute_tolerance, lower_bound, upper_bound, function)
end

def fourthroottwo(x)
	return x**4 - 2
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

