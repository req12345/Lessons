puts 'Введите число'
day = gets.chomp.to_i
puts 'Введите месяц'
month = gets.chomp.to_i
puts 'Введите год'
year = gets.chomp.to_i

leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days[1] = 29 if leap == true

if month == 1
  puts "Порядковый номер даты #{day}"
else
  days[0..(month - 2)].each do |n|
    day += n
  end
  puts "Порядковый номер даты #{(day)}"
end
