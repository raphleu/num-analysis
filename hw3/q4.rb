def simpsons_rule(f, a, b, n)
	h = (b - a) / n
	k = 0.0
	x = a + h

	(1..n/2+1).each do
		k += 4 * send(f, x)
		x += 2 * h
	end

	x = a + 2 * h

	(1..n/2).each do
		k += 2 * send(f, x)
		x += 2 * h
	end

	return (h/3.0) * (send(f, a) + send(f, b) + k) 
end

def density_of_photons(x)
	return  (x**2 / ((Math::E**(x / (1 - x)) - 1) * (1 - x)**4) ) # * t**2
end

def simple(x)
	return x ** 2
end

#integral: 2.404113806318499
#target value = 1.20205690315925
#found upper bound: 0.70209382 (gets 1.20206)


def photon_median()
	target_value = 1.20205690315925
	diff = 0
	upper_bound = 0.7020926
	while diff < target_value
		diff = simpsons_rule("density_of_photons", 0.000001, upper_bound, 10000000)
		upper_bound += 0.00000001
	end
	puts upper_bound - 0.00000001
end	

# puts simpsons_rule("density_of_photons", 0.000001, 0.99999, 100000)
photon_median()