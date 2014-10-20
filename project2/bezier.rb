require 'matrix'

x_values = []
y_values = []
slopes = []

File.open("input2") do |f|
	f.each_line do |line|
		row = line.chomp.split(" ")
	  x_values << row[0].to_f
	  y_values << row[1].to_f
	  slopes << row[2].to_f
	end
end

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

	puts "t: #{t} #{x_out_values[0]} #{y_out_values[0]}"
end