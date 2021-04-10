require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_passenger.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_passenger.rb'

class Main
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def call
    print_menu
    loop do
      puts 'Выберите действие:'
      action = gets.chomp.to_i

      case action
      when 1 then create_new_station
      when 2 then stations_list(@stations)
      when 3 then create_new_train
      when 4 then create_new_route
      when 5 then edit_route
      when 6 then train_route_take
      when 7 then attach_wagons_to_train
      when 8 then detach_wagons_to_train
      when 9 then move_train_next_station
      when 10 then move_train_previous_station
      when 11 then trains_list
      when 0 then break
      end
    end
  end

  private

# Все нижеперечисленные методы помещены в приватную секцию, так как используются только внутри класса
# Пользователю программы доступ к этим методам не нужен, они вызываются только из Меню
  def print_menu
    puts '1. Новая станция'
    puts '2. Список станций'
    puts '3. Новый поезд'
    puts '4. Новый маршрут'
    puts '5. Редактирование маршрутов'
    puts '6. Назначение маршрута поезду'
    puts '7. Добавить вагоны к поезду'
    puts '8. Отцепить вагоны от поезда'
    puts '9. Переместить поезд на следующую станцию'
    puts '10. Переместить поезд на следующую станцию'
    puts '11. Список поездов'
    puts '0. Завершить программу'
  end

  def create_new_station
    puts 'Введите имя станции'
    name = gets.chomp
    station = Station.new(name)
    @stations << station
    puts "Вы создали станцию #{station.name}"
  end

  def stations_list(stations)
    stations.each_with_index do |station, i|
      puts "#{i}. #{station.name}"
    end
  end

  def trains_list(stations)
    @trains.each_with_index do |train, i|
      puts "#{i}. #{train.number}"
    end
  end

  def train_selection
    puts 'Выберите поезд из списка'
    @trains.each_with_index {|train, i| puts "#{i}. #{train.number}"}
    i = gets.chomp.to_i
    train_selected = @trains[i]
  end

  def route_selection
    puts 'Выберите маршрут из списка:'
    @routes.each_with_index {|route, i| puts "#{i}. #{route.initial.name} — #{route.final.name}"}
    index_route = gets.chomp.to_i
    route_selected = @routes[index_route]
  end

  def create_new_train
    puts 'Введите номер поезда'
    number = gets.chomp

    puts 'Выберите тип поезда:
    1. пассажирский
    2. грузовой'

    type = gets.chomp.to_i

    train =
      if type == 1
        TrainPassanger.new(number)
      elsif type == 2
        TrainCargo.new(number)
      end

    if train.nil?
      puts 'Неверное число, вернитесь в начало'
      return
    else
      @trains << train
      puts "Вы создали поезд #{train.number} с типом #{train.type}"
    end
  end

  def create_new_route
    if @stations.count < 2
      puts 'Создайте сначала как минимум 2 станции'
      return
    end

    stations_list(@stations)

    puts 'Выберите первую станцию маршрута'
    initial_index = gets.chomp.to_i
    initial = @stations[initial_index]

    puts 'Выберите конечную станцию маршрута'
    final_index = gets.chomp.to_i
    final = @stations[final_index]

    route = Route.new(initial, final)
    @routes << route
    puts "Вы создали новый маршрут #{initial.name} — #{final.name}"
  end

  def edit_route
    route = route_selection
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    choice = gets.chomp.to_i

    if choice == 1
      add_station_to_route(route)
    elsif choice == 2
      delete_station_from_route(route)
    end
  end

    def add_station_to_route(route)
    puts 'Выберите добавляемую станцию'
    stations_list(@stations)
    i = gets.chomp.to_i
    station_selected = @stations[i]

    route.add_station(station_selected)
    puts "Станция добавлена, новый маршрут:"
    stations_list(route.stations)
  end

  def delete_station_from_route(route)
    if route.stations.count < 2
      puts 'Вы не можете удалить начальную и конечную станции'
      return

    else
    puts 'Какую станцию вы хотите удалить?'
    stations_list(route.stations)
    i = gets.chomp.to_i
    station_selected = route.stations[i]

    route.delete_station(station_selected)
    puts 'Станция удалена, новый список:'
    stations_list(route.stations)
    end
  end

  def train_route_take
    if @trains.empty?
      puts 'Сначала создайте поезд'
      return

    else
      route = route_selection
      train = train_selection
      train.route_take(route)
      puts "Поезд #{train.number} назначен на маршрут #{route.initial.name} — #{route.final.name} "
    end
  end

  def attach_wagons_to_train
    train = train_selection
    puts 'Введите название прицепляемого вагона'
    wagon = gets.chomp
    train.attach_wagon(wagon)
    puts "Вагон #{wagon} прицеплен"
  end

  def detach_wagons_to_train
    train = train_selection

    puts 'Введите название отцепляемого вагона'
    puts "#{train.wagons}"
    wagon = gets.chomp
    train.detach_wagon(wagon)
    puts "Вагон #{wagon} отцеплен"
  end

  def move_train_next_station
    train = train_selection
    train.move_next_station
  end

  def move_train_previous_station
    train = train_selection
    train.move_previous_station
  end
end

Main.new().call
