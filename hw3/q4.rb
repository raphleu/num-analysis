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

def density_of_photons(l, h, c, k, t)
	return ((8.0 * Math::PI) / (l**4)) * (1 / (Math::E**((h * c) / (l * k * t)) - 1))
end

def simple(x)
	return x ** 2
end

puts simpsons_rule("simple", 1.0, 5.0, 1000)