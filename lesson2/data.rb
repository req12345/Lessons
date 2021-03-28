puts 'Введите число'
day = gets.chomp.to_i
puts 'Введите месяц'
month = gets.chomp.to_i
puts 'Введите год'
year = gets.chomp.to_i


leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

days =
if leap == true
  [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
else
  [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
end

d = 0
if month == 1
  d = day
  puts "Порядковый номер даты #{d}"
else
    days[0..(month - 2)].each do |n|
  d += n
  end
  puts "Порядковый номер даты #{(d + day)}"
end
