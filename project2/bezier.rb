##
##This code computes the bezier interpolation of points 
##given in an input file where rows are the x value followed 
##by the y value
##
##To run this program: $ruby bezier.rb
##
##input1,3,4,5 are for the cos function, varying the 4th point
##input6 is for the x squared function
##input7 is for the square root squared function
##input8 is for the derivative of the cos function
##

def cos_func(x)
	return -Math.cos(x-0.2)
end

def squared_func(x)
	return 1-x**2
end

def square_root_squared_func(x)
	return (5-x**2)**(1.0/2.0)
end

def derivative_of_cos_func(x)
	return -Math.sin(0.2-x)
end

puts "Enter the name of the input file: (must be in the same directory as this program)"
file_name = gets.chomp

x_values = []
y_values = []
slopes = []

File.open(file_name) do |f|
	f.each_line do |line|
		row = line.chomp.split(" ")
	  x_values << row[0].to_f
	  y_values << row[1].to_f
	  slopes << row[2].to_f
	end
end

output_file = open("input8_with_error.csv", 'w')

iterations = 0.0
max_iterations = 100.0
n = x_values.size

while iterations <= max_iterations

	t =  (iterations / max_iterations)
	u = (1.0 - t)
	x_out_values = x_values.dup
	y_out_values = y_values.dup

	(1..(n - 1)).each do |i|
		(0..(n - i - 1)).each do |j|
			x_out_values[j] = u * x_out_values[j] + t * x_out_values[j + 1]
			y_out_values[j] = u * y_out_values[j] + t * y_out_values[j + 1]
		end
	end

	iterations += 1.0

	puts "t: #{t} #{x_out_values[0]} #{y_out_values[0]}, error: #{(derivative_of_cos_func(x_out_values[0]) - y_out_values[0]).abs}"
	output_file.write("#{x_out_values[0].round(5)},#{y_out_values[0].round(5)}, error: #{(derivative_of_cos_func(x_out_values[0]) - y_out_values[0]).abs}\n")
end

output_file.close