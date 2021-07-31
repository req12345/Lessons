#Идеальный вес

puts 'Каково Ваше имя?'
name = gets.chomp
puts 'Каков Ваш рост?'
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

if  ideal_weight >= 0
  puts "#{name}, Ваш идеальный веc #{ideal_weight.round(1)}"
else
  puts "#{name}, Ваш вес уже оптимальный"
end
