require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_passenger.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_passenger.rb'

# puts 'Введите 4, чтобы назначить маршрут поезду'
# puts 'Введите 5, чтобы добавить вагоны к поезду'
# puts 'Введите 6, чтобы отцепить вагон от поезда'
# puts 'Введите 7, чтобы переместить поезд вперед или назад'
# puts 'Введите 8, чтобы просмотреть список станций и список поездов на станциях'
# puts 'Введите 0, чтобы завершить программу'

stations = []
trains = []
routes = []

loop do
  puts '1. Новая станция'
  puts '2. Новый поезд'
  puts '3. Новый маршрут и редактирование маршрутов'
  action = gets.chomp.to_i

  break if action == 0
  case action

  when 1
    puts 'Введите имя станции'
    name = gets.chomp
    station = Station.new(name)
    stations << station
    puts "Вы создали станцию #{station.name}"

  when 2
    puts 'Введите номер поезда'
    number = gets.chomp
    puts 'Выберите тип поезда:
    1. пассажирский
    2. грузовой'
    type = gets.chomp.to_i

    if type == 1
      train = TrainPassanger.new(number)
      trains << train
      puts "Вы создали пассажирский поезд #{train.number}"
    elsif type == 2
      train = TrainCargo.new(number)
      trains << train
      puts "Вы создали грузовой поезд #{train.number}"
    else
      puts 'Начните с начала'
    end

# Создание новых маршрутов и управлять станциями в нем (добавлять, удалять)
  when 3
    puts '1. Создать новый маршрут'
    puts '2. Управление существующими маршрутами'
    choice = gets.chomp.to_i

    if choice == 1
      puts 'Введите начальную станцию'
      initial = gets.chomp
      puts 'Введите конечную станцию'
      final = gets.chomp
      route = Route.new(initial, final)
    end

    if choice == 2
      break if routes.empty? == true
      routes.each {|route| puts route}
      puts 'Введите название маршрута'

      # запрашиваем название маршрута
      # запрашиваем что мы хотим с ним сделать, добавить или удалить станцию
      # добавляем или удаляем станцию
    end
  end
end

  # when 2
  #   puts stations.map(&:name).join(', ')
  #  end
