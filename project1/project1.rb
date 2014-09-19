def bisection(absolute_tolerance, lower_bound, upper_bound, function, m, xi, kj, nj)
	abort "Root not bracketed!" if (send(function, lower_bound, m, xi, kj, nj) * send(function, upper_bound, m, xi, kj, nj)) > 0
	if send(function, lower_bound, m, xi, kj, nj) > 0
		temp_lower_bound = lower_bound.to_f
		lower_bound = upper_bound.to_f
		upper_bound = temp_lower_bound
	end
  dx = upper_bound.to_f - lower_bound.to_f
 	new_y = 1.0 + absolute_tolerance.to_f
 	number_of_iterations = 0
 	until new_y.abs < absolute_tolerance
 		dx /= 2.0
 		new_y = send(function, lower_bound + dx, m, xi, kj, nj)
 		if new_y < 0
 			lower_bound += dx
 		end
 		puts "xmid: #{lower_bound}, y value: #{new_y}\\\\"
 		number_of_iterations += 1
 	end
 	print_conclusion(new_y, lower_bound + dx, number_of_iterations)
end

def fpi(absolute_tolerance, lower_bound, upper_bound, function, m, xi, kj, nj)
	number_of_iterations = 0
	old_x = lower_bound.to_f
	difference = 1.0 + absolute_tolerance.to_f
	until difference.abs < absolute_tolerance or difference.nan? or number_of_iterations > 100 
		new_x = send(function, old_x, m, xi, kj, nj)
		difference = new_x - old_x
		puts "old x: #{old_x}, new x: #{new_x}, difference: #{difference}\\\\"
		old_x = new_x
		number_of_iterations += 1
	end
	print_conclusion(difference, new_x, number_of_iterations)
end

def newtonmethod(absolute_tolerance, lower_bound, upper_bound, function, m, xi, kj, nj)
	iterations = 0
	difference = 1 + absolute_tolerance
	funcval = 0
	derivval = 0
	until difference.abs < absolute_tolerance or iterations > 100
		xold = lower_bound.to_f
		funcval = send(function, xold, m, xi, kj, nj).to_f
		derivval = deriv_chemfunction(xold, m, kj, nj).to_f
		difference = funcval / derivval
		lower_bound = xold - difference 
		puts "old x: #{xold}, new x: #{lower_bound}, difference: #{difference}\\\\"
		iterations += 1
	end
	print_conclusion(difference, lower_bound, iterations)
end

def chemfunction(x, m, xi, kj, nj)
	x.to_f * (1 + sum_function(x, m, kj, nj)) - xi
end

def chemfunctionoveralpha(x, m, xi, kj, nj)
	alpha = 1.0
	((1.0 / (1.0 + alpha)) * (xi.to_f + x.to_f * (alpha - sum_function(x, m, kj, nj))))

end

def deriv_chemfunction(x, m, kj, nj)
	(1 + sum_function(x, m, kj, nj)) + x.to_f * deriv_sum_function(x, m, kj, nj)
end

def sum_function(x, m, kj, nj)
	sum = 0.0
	(1..m).each do |i|
		sum += (kj[i - 1].to_f * nj[i - 1].to_f) / (1.0 + kj[i - 1].to_f * x.to_f)
	end
	sum
end

def deriv_sum_function(x, m, kj, nj)
	sum = 0.0
	(1..m).each do |i|
		sum += - ((kj[i - 1].to_f**2) * nj[i - 1].to_f) /  (((kj[i - 1].to_f * x.to_f) + 1)**2.0)
	end
	sum
end

def print_conclusion(final_y, final_x, number_of_iterations)
	puts "Final y value: #{final_y}"
	puts "Final x value: #{final_x}"
	puts "Number of iterations: #{number_of_iterations}"
end

#Here's where the stuff starts when you run the program

functions = ["chemfunction", "chemfunctionoveralpha"]
methods = ["bisection", "fpi", "newtonmethod"]

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

puts "Enter M: "

m = gets.chomp.to_f

puts "Enter xi: (the weird greek letter)"

xi = gets.chomp.to_f

puts "Enter M number of k's separated by spaces (ie. 1 3 4 1...): "

kj = gets.chomp.split(' ')

puts "Enter M number of n's separated by spaces (ie. 1 3 4 1...): "

nj = gets.chomp.split(' ')

puts "Enter absolute_tolerance: "

absolute_tolerance = gets.chomp.to_f

puts "Enter lower bound: (for FPI and newton's method this is the initial guess. upper bound will mean nothing)"

lower_bound = gets.chomp.to_f

puts "Enter upper bound: "

upper_bound = gets.chomp.to_f

send(selected_method, absolute_tolerance, lower_bound, upper_bound, selected_function, m, xi, kj, nj)