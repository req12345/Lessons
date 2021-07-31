p 'Введите Ваше имя'
first_name = gets.chomp

p 'Введите Вашу фамилию'
last_name = gets.chomp

p 'Введите Ваш возраст'
age = gets.chomp.to_i

if young(age)
  puts "Привет #{first_name} #{last_name}. Тебе меньше 18, но учиться программировать никогда не рано."
else
  puts "Привет #{first_name} #{last_name}. Самое время заняться делом!"
end

def young(age)
  age < 18
end
