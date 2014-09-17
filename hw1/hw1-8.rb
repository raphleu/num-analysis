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
	end
	puts "final v: #{v}, final w: #{w}, number of iterations: #{iterations}"
end

def calculate_determinant(v, w)
	newtonfunctiondfdv(v, w) * newtonfunctiondgdw(v, w) - newtonfunctiondfdw(v, w) * newtonfunctiondgdv(v, w)
end

puts "Enter initial guess for v: "
v = gets.chomp.to_f

puts "Enter initial guess for w: "
w = gets.chomp.to_f

newtons_method(v, w)