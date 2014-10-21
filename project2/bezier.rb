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
	return -Math.cos(x - 0.2)
end

def squared_func(x)
	return 1 - x**2
end

def square_root_squared_func(x)
	return (5 - x**2)**(1.0 / 2.0)
end

def derivative_of_cos_func(x)
	return -Math.sin(0.2 - x)
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

output_file = open("output1.csv", 'w')

iterations = 0.0
max_iterations = 20.0
n = x_values.size

(0..(n - 2)).each do |i|

	interval_x_values = []
	interval_y_values = []
	step_size = (x_values[i + 1] - x_values[i]).abs / 3.0

	(x_values[i]..x_values[i + 1]).step(step_size).each do |new_x|
		interval_x_values << new_x
	end

	interval_y_values << y_values[i]
	interval_y_values << y_values[i] + slopes[i] * step_size
	interval_y_values << y_values[i + 1] - slopes[i + 1] * step_size
	interval_y_values << y_values[i + 1]

	num_interval_points = interval_x_values.size

	while iterations <= max_iterations

		t =  (iterations / max_iterations)
		u = (1.0 - t)
		x_out_values = interval_x_values.dup
		y_out_values = interval_y_values.dup

		(1..(num_interval_points - 1)).each do |i|
			(0..(num_interval_points - i - 1)).each do |j|
				x_out_values[j] = u * x_out_values[j] + t * x_out_values[j + 1]
				y_out_values[j] = u * y_out_values[j] + t * y_out_values[j + 1]
			end
		end

		iterations += 1.0

		# puts "t: #{t} #{x_out_values[0]} #{y_out_values[0]}, error: #{(derivative_of_cos_func(x_out_values[0]) - y_out_values[0]).abs}"
		puts "t: #{t} #{x_out_values[0]} #{y_out_values[0]}"
		output_file.write("#{x_out_values[0].round(5)},#{y_out_values[0].round(5)}\n")
		# output_file.write("#{x_out_values[0].round(5)},#{y_out_values[0].round(5)}, error: #{(derivative_of_cos_func(x_out_values[0]) - y_out_values[0]).abs}\n")
	end

	iterations = 0.0

end
output_file.close