
basket = {}

loop do
  puts 'Что будем покупать?'
  puts 'Введите название товара'
  title = gets.chomp.to_s
  break if title == 'стоп'
  puts 'Введите цену за единицу'
  price_inpt = gets.chomp.to_f
  puts 'Введите количество единиц товара'
  amount_inpt = gets.chomp.to_f
  basket[title] = {'price' => price_inpt, 'amount' => amount_inpt}
  puts 'Если хватит введите \'стоп\''
end

puts basket

total_summ = 0

basket.each do |position, info|
  summ = info['price'] * info['amount']
  puts "#{position} - #{summ}"

  total_summ += summ
end
puts "Общая стоимость = #{total_summ}"
