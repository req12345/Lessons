# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('a'..'z').to_a
vowel = 'a e i o u y'.split(' ')
result = {}
alphabet.each do |let|
  if vowel.include?(let)
    result[let] = (alphabet.index(let) - 1)
  end
end

puts result
