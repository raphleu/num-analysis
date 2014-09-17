def taylor_series(x_val, part)
	actual_y = (Math::E)**(3.0 * x_val)
	iterations = 0
	calculated_y = 1.0
	previous_increment = 1.0
	if part == 1
		while iterations < 100 and (calculated_y - actual_y).abs > 0.00000001
			puts calculated_y
			increment = previous_increment * 3.0 * x_val / (iterations + 1.0)
			previous_increment = increment
			calculated_y += increment
			iterations += 1
		end
	elsif part == 2
		while (previous_increment).abs > 0.0000000000001
			puts calculated_y
			increment = previous_increment * 3.0 * x_val / (iterations + 1.0)
			previous_increment = increment
			calculated_y += increment
			iterations += 1
		end
	end	

	puts "Iterations: #{iterations}, calculated value: #{calculated_y}, actual value: #{actual_y}"
end

puts "For part 1 enter 1, for part 2 enter 2"
part = gets.chomp.to_i
puts "Please enter value for x: "
x_val = gets.chomp.to_f
taylor_series(x_val, part)