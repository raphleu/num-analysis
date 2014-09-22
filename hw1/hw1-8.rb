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

def newtons_method(v, w)
	iterations = 0
	fvw = 10
	gvw = 10
	while iterations < 100 and (gvw > 0.000000001 or fvw > 0.000000001)
		determinant = calculate_determinant(v, w)
		fvw = newtonfunctionfvw(v, w)
		gvw = newtonfunctiongvw(v, w)
		delta_v = (fvw * newtonfunctiondgdw(v, w) - gvw * newtonfunctiondfdw(v, w)) / determinant
		delta_w = (-fvw * newtonfunctiondgdv(v, w) + gvw * newtonfunctiondfdv(v, w)) / determinant
		v -= delta_v
		w -= delta_w
		iterations += 1
		puts "#{iterations}: v: #{v}, w: #{w}\\\\"
	end
	puts "final v: #{v}, final w: #{w}, number of iterations: #{iterations}"
end

def calculate_determinant(v, w)
	newtonfunctiondfdv(v, w) * newtonfunctiondgdw(v, w) - newtonfunctiondfdw(v, w) * newtonfunctiondgdv(v, w)
end

def onednewton(w)
	v = 0.083333 / (0.004 + w)**2 + 0.0011111 * (0.04 + 2*w)/ w**2
	(0.322685 / ((1.0 - v)**(1.0/2.0)) - 0.5 * w - 0.02) * v + (-(0.05 * v) - 0.0011111 / w**3.0 - 0.5)
end

def onednewtonderiv(w)
	v = 0.0000888888/(w**3) + 0.00222222/(w**2) - 0.166666/(w + 0.04)**3
	-0.04 * v / 2.0 + 0.0011111 * w**(-3) - 1.0 + 0.5
end

def newtonmethod1d(x_val)
	iterations = 0
	absolute_tolerance = 0.000000001
	difference = 1 + absolute_tolerance
	funcval = 0
	derivval = 0
	until (difference.abs < absolute_tolerance)
		xold = x_val.to_f
		funcval = newton1d(xold).to_f
		derivval = onednewtonderiv(xold).to_f
		difference = funcval / derivval
		lower_bound = xold - difference 
		puts "old x: #{xold}, new x: #{lower_bound}, difference: #{difference}\\\\"
		iterations += 1
	end
	print_conclusion(difference, lower_bound, iterations)
end

def newton1d(w)
	#B = 0.04
	#S = 0.00111111
	#Q = 0.083333
	#D = 1.29074
	#N = -1.774598
	w = 2.19
	raise (((-0.04 / 2.0) * (1.0 + (0.00111111 * (0.04 + 2.0 * w) / (w**2.0 * (0.04 + w)))) + (0.00111111 / 2.0) * w**(-2.0) - w + (1.0 / 2.0) * w * (1.0 - ((0.00111111 * (0.04 + 2.0 * w) / (w**2.0 * (0.04 + w))))) - 1.29074 * (1.0 - ((0.00111111 * (0.04 + 2.0 * w)) / (w**2.0 * (0.04 + w)**2.0)))**(1.0 / 2.0)).inspect
end

def print_conclusion(final_y, final_w, number_of_iterations)
	puts "Final y value: #{final_y}"
	puts "Final w value: #{final_w}"
	puts "Number of iterations: #{number_of_iterations}"
end

puts "For 2D solver put '2', for 1D solver put '1'"
d = gets.chomp.to_i

if d == 2
	puts "Enter initial guess for v: "
	v = gets.chomp.to_f

	puts "Enter initial guess for w: "
	w = gets.chomp.to_f
	newtons_method(v, w)
elsif d == 1
	puts "Enter intial guess for w: "
	guess = gets.chomp.to_f

	newtonmethod1d(guess)
end
