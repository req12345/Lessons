#Заполнить массив числами от 10 до 100 с шагом 5
num_pitch_5 = []
(10..100).each do |i|
  if i % 5 == 0
  num_pitch_5.push(i)
  end
end
puts num_pitch_5.to_s
