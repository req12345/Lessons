#Заполнить массив числами от 10 до 100 с шагом 5
num_pitch_5 = []
(10..100).step(5) {|i| num_pitch_5 << i}
puts num_pitch_5
