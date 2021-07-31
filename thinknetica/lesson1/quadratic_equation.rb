#Решение квадратного уравнения
puts 'Задайте число a'
a = gets.chomp.to_i
puts 'Задайте число b'
b = gets.chomp.to_i
puts 'Задайте число c'
c = gets.chomp.to_i

puts "Ваше уравнение #{a} * x**2 + #{b} * x + #{c} = 0"

d = (b**2 - 4 * a * c)

if d > 0
  x1 = ((-b + Math.sqrt(d))/2 * a)
  x2 = ((-b - Math.sqrt(d))/2 * a)
  puts "D = #{d}"
  puts "X1 =#{x1.round(2)}, X2 = #{x2.round(2)}"
elsif d == 0
  x = (-b/2 * a)
  puts "D = #{d}, единственный корень Х = #{x}"
else
  puts "D = #{d}, корней нет"
end
