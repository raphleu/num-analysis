require 'matrix'

# The matrix inverting code was from the ruby matrix gem ( built-in )

puts "Enter number of rows: "
num_rows = gets.chomp.to_i

# mat = Matrix.identity(num_rows)
mat = []
# mat.to_a.each {|r| puts r.inspect}
for i in 1..num_rows
  puts "Enter data for row #{i} in the form: a1 a2 ... an"
  row = []
  inp = gets.chomp.split(" ")
  inp.each do |matrix_element|
  	row << matrix_element.to_i
  end
  mat << row
end

matr = Matrix.rows(mat)

begin
	matrInv = matr.inverse
	matrInv.to_a.each {|r| puts r.inspect}
rescue 
	puts "Invalid input"
end

