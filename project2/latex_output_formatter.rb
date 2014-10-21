file_name = "input7_with_error.csv"
output_file = open("latex_" + file_name, 'w')

File.open(file_name) do |f|
	f.each_line do |line|
		row = line.chomp.split(",")
		output_file.write("#{row[0]}&#{row[1]}&#{row[2][8..-1]}\\\\\n")
	end
end

output_file.close