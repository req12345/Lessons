#Заполнить массив числами фибоначчи до 100
fibo = []
i = 0
loop do
  if fibo.size < 2
    fibo << i
    i += 1
  else
    i = fibo[-1] + fibo[-2]
    if i <= 100
    fibo << i
  else
    break
  end
  end
end

puts fibo.to_s
