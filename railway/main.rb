require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_passenger.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_passenger.rb'

#
# puts 'Введите 5, чтобы добавить вагоны к поезду'
# puts 'Введите 6, чтобы отцепить вагон от поезда'
# puts 'Введите 7, чтобы переместить поезд вперед или назад'
# puts 'Введите 8, чтобы просмотреть список станций и список поездов на станциях'

class Main

attr_reader :trains, :route, :stations

@trains = []
@route = []
@stations = [@initial, *@intermediate_station, @final]
@intermediate_station = []

  loop do
    puts '1. Новая станция'
    puts '2. Новый поезд'
    puts '3. Новый маршрут'
    puts '4. Редактирование маршрутов'
    puts '5. Назначение маршрута поезду'
    puts '0. Завершить программу'
    action = gets.chomp.to_i


    case action

    when 1
      puts 'Введите имя станции'
      name = gets.chomp
      station = Station.new(name)
      @stations << station
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
        @trains << train
        puts "Вы создали пассажирский поезд #{train.number}"
      elsif type == 2
        train = TrainCargo.new(number)
        @trains << train
        puts "Вы создали грузовой поезд #{train.number}"
      else
        puts 'Начните с начала'
      end

    when 3
      puts 'Введите начальную станцию'
      initial = gets.chomp
      puts 'Введите конечную станцию'
      final = gets.chomp
      route = Route.new(initial, final)
      @route << route
      puts "Вы создали маршрут #{route}"

    when 4
      puts 'Выберите маршрут из списка:'
      @route.each_index {|r| puts "#{r}  - #{@route[r]}"}
      index_route = gets.chomp.to_i
      route_selected = @route[index_route]
      puts '1. Добавить станцию'
      puts '2. Удалить станцию'
      choice = gets.chomp.to_i
      case choice
        when 1
          route = route_selected
          puts 'Введите название станции'
          name = gets.chomp
          route.add_station(name)
          puts "Вы добавили станцию: #{name}"
          puts "#{@route}"

        when 2
          route = route_selected
          puts "Введите название станции"
          name = gets.chomp
          route.delete_station(name)
          puts "Вы удалили станцию: #{name}"
          puts "#{@route}"
        end

    when 5

      puts 'Выберите поезд из списка'
      @trains.each_index {|t| puts "#{t}  - #{@trains[t]}"}
      index_train = gets.chomp.to_i
      train_selected = @trains[index_train]
      puts 'Выберите маршрут из списка:'
      @route.each_index {|r| puts "#{r}  - #{@route[r]}"}
      index_route = gets.chomp.to_i
      route_selected = @route[index_route]

      train_selected.route_take(route_selected)
      puts "#{train_selected}"
      #Назначение маршрута поезду'
      #выбираем необходимы поезд, выбираем необходимы маршрут, назначаем поезду маршрут

    when 0
    puts 'До свидания!'
    break if action == 0
    end
  end
end
