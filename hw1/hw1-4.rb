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
 		puts "xmid: #{lower_bound}, y value: #{new_y}\\\\"
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
		puts "xold: #{lower_bound}, xnew: #{upper_bound}, y value: #{new_y}\\\\"
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
		puts "lower bound: #{lower_bound}, upper bound: #{upper_bound}, y value: #{new_val}\\\\"
		number_of_iterations += 1
	end
	print_conclusion(new_val, new_x, number_of_iterations)
end

def fpi(absolute_tolerance, lower_bound, upper_bound, function)
	number_of_iterations = 0
	old_x = lower_bound
	difference = 1 + absolute_tolerance
	until difference.abs < absolute_tolerance
		new_x = send(function, old_x)
		difference = new_x - old_x
		# puts "old x: #{old_x}, new x: #{new_x}, difference: #{difference}"
		old_x = new_x
		number_of_iterations += 1
	end
	print_conclusion(difference, new_x, number_of_iterations)
end

def fourthroottwo(x)
	x**4 - 2
end

#for question 4
def fpifunction0(x)
	(x / 2) + (1 / x**3)
end

#for question 4
def fpifunction1(x)
	((2 * x) / 3 + 2 / (3 * x**3))
end

#for question 4
def fpifunction2(x)
	x - (0.15) * (x**4 - 2.0)
end

#for question 5
def fpifunction3(x)
	(2.0 * x**3 - 1) / 6.0
end

#for question 5
def fpifunction4(x)
	x - (2.0 * x**3 - 6.0 * x - 1.0) / (6.0 * x**2 - 6.0)
end

def newtonfunctionfvw(v, w)
	v * (0.04 + w)**2.0 - 0.0011111 * (0.04 + 2.0 * w) / (w**2.0) - 0.083333
end

def newtonfunctiongvw(v, w)
	-(0.02) * (1.0 + v) + 0.00055555 * (w**(-2.0)) - w + 0.5 * ((1.0 - v) * w - (1.29074 * (1.0-v)**(1.0/2.0))) + 1.774598 
end

def newtonfunctiondfdv(v, w) 
	(0.04 + w)**2.0
end

def newtonfunctiondfdw(v, w)
	v *  (0.08 + 2.0 * w) + (0.0022222 * w + 0.000088888) / w**3
end

def newtonfunctiondgdv(v, w)
	0.322685 / ((1.0 - v)**(1.0/2.0)) - 0.5 * w - 0.02
end

def newtonfunctiondgdw(v, w)
	-(0.05 * v) - 0.0011111 / w**3.0 - 0.5
end

def print_conclusion(final_y, final_x, number_of_iterations)
	puts "Final y value: #{final_y}"
	puts "Final x value: #{final_x}"
	puts "Number of iterations: #{number_of_iterations}"
end

#Here's where the stuff starts when you run the program

functions = ["fourthroottwo", "fpifunction0", "fpifunction1", "fpifunction2", "fpifunction3", "fpifunction4"]
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

puts "Enter lower bound: (for FPI this is the initial guess. upper bound will mean nothing)"

lower_bound = gets.chomp.to_f

puts "Enter upper bound: "

upper_bound = gets.chomp.to_f

send(selected_method, absolute_tolerance, lower_bound, upper_bound, selected_function)