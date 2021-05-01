require_relative 'manufacturer.rb'
require_relative 'instancecounter.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'wagon.rb'
require_relative 'train_cargo.rb'
require_relative 'train_passenger.rb'
require_relative 'route.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_passenger.rb'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def call
    print_menu
    loop do
      puts 'Выберите действие:'
      action = gets.chomp.to_i

      case action
      when 1 then create_new_station
      when 2 then list_stations_trains
      when 3 then create_new_train
      when 4 then create_new_route
      when 5 then edit_route
      when 6 then train_route_take
      when 7 then wagons_operation
      when 8 then move_train
      when 9 then show_trains_on_station
      when 10 then show_trains_wagons
      when 11 then take_place
      when 0 then break
      end
    end
  end

  private

  def print_menu
    puts '1. Новая станция'
    puts '2. Список станций и поездов'
    puts '3. Новый поезд'
    puts '4. Новый маршрут'
    puts '5. Редактирование маршрутов'
    puts '6. Назначение маршрута поезду'
    puts '7. Прицепить/отцепить вагоны к поезду'
    puts '8. Переместить поезд на следующую/предыдущую станцию'
    puts '9. Список поездов на станции'
    puts '10. Список вагонов у поезда'
    puts '11. Занять места или объем в вагоне'
    puts '0. Завершить программу'
  end

  def create_new_station
    puts 'Введите имя станции'
    name = gets.chomp
    station = Station.new(name)
    @stations << station
    puts "Вы создали станцию #{station.name}"
  end

  def list_stations_trains

    puts '1. Посмотреть список станций'
    puts '2. Посмотреть список поездов'
    choice = gets.chomp.to_i

    if choice == 1
      stations_list(@stations)
    elsif choice == 2
      trains_list
    end
  end

  def stations_list(stations)
    stations.each_with_index do |station, i|
      puts "#{i}. #{station.name}"
    end
  end

  def trains_list
    @trains.each_with_index do |train, i|
      puts "#{i + 1}.  № #{train.number} - тип: #{train.type}"
    end
  end

  def train_selection
    puts 'Выберите поезд из списка'
    @trains.each_with_index {|train, i| puts "#{i}. #{train.number}"}
    i = gets.chomp.to_i
    train_selected = @trains[i]
  end

  def station_selection
    puts 'Выберите станцию'
    stations_list(@stations)
    i = gets.chomp.to_i
    station_selected = @stations[i]
  end

  def route_selection
    puts 'Выберите маршрут из списка:'
    @routes.each_with_index {|route, i| puts "#{i}. #{route.initial.name} — #{route.final.name}"}
    index_route = gets.chomp.to_i
    route_selected = @routes[index_route]
  end

  def wagon_selection(train)
    puts 'Выберите вагон'
    train.wagons.each_with_index {|wagon, i| puts "#{i}. #{wagon.number}"}
    i = gets.chomp.to_i
    wagon_selected = train.wagons[i]
  end

  def create_new_train
    train =
      begin
        puts "Введите номер поезда\n(три буквы или цифры, необязательный дефис и еще 2 буквы или цифры)"
        number = gets.chomp

        puts "Выберите тип поезда:\n1. пассажирский\n2. грузовой"
        type = gets.chomp.to_i

        case type
        when 1 then TrainPassenger.new(number)
        when 2 then TrainCargo.new(number)
        else nil
        end
      rescue => e
        puts e
        retry
      end

    if train.nil?
      puts 'Неверное число, вернитесь в начало'
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
    station_selected = station_selection
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
      puts 'Станция удалена, новый маршрут:'
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

  def wagons_operation
    puts '1. Добавить вагоны к поезду'
    puts '2. Отцепить вагоны от поезда'
    choice = gets.chomp.to_i
    if choice == 1
      attach_wagons_to_train
    elsif choice == 2
      detach_wagons_to_train
    end
  end

  def attach_wagons_to_train
    train = train_selection
    puts 'Введите № прицепляемого вагона'
    number = gets.chomp
    if train.type == 'passenger'
      puts 'Введите количество мест'
      total_sits = gets.chomp.to_i
      wagon = WagonPassanger.new(number, total_sits)
    elsif train.type == 'cargo'
      puts 'Введите объем вагона'
      total_volume = gets.chomp.to_i
      wagon = WagonCargo.new(number, total_volume)
    end
    train.attach_wagon(wagon)
    puts "Вагон #{wagon.number} прицеплен"
  end

  def detach_wagons_to_train
    train = train_selection
    if train.wagons.size == 0
      puts 'В составе нет вагонов, сначала прицепите вагон!'
    else
      puts "#{train.wagons}"
      puts 'Введите название отцепляемого вагона'
      wagon = gets.chomp
      train.detach_wagon(wagon)
      puts "Вагон #{wagon} отцеплен"
      puts "#{train.wagons}"
    end
  end

  def move_train
    puts '1. Переместить поезд на следующую станцию'
    puts '2. Переместить поезд на предыдущую станцию'
    choice = gets.chomp.to_i
    if choice == 1
      move_train_next_station
    elsif choice == 2
      move_train_previous_station
    end
  end

  def move_train_next_station
    train = train_selection
    train.move_next_station
    puts "Поезд на станции: #{train.station.name}"
  end

  def move_train_previous_station
    train = train_selection
    train.move_previous_station
    puts "Поезд на станции: #{train.station.name}"
  end

  def show_trains_on_station
    station = station_selection
    puts 'На станции следующие поезда'
    station.trains_on_station do |train|
    puts "Номер: #{train.number}, тип: #{train.type}, вагонов: #{train.wagons.size}"
    end
  end

  def show_trains_wagons
    train = train_selection
    puts 'В составе поезда следующие вагоны:'
    train.trains_wagons do |wagon|
      if wagon.type == 'passanger'
        puts "№ #{wagon.number}, тип #{wagon.type} \nсвободно мест: #{wagon.vacanted_sits}, занято #{wagon.occupied_sits}"
      elsif wagon.type == 'cargo'
        puts "№ #{wagon.number}, тип #{wagon.type} \nсвободный объем: #{wagon.remaining_volume}, занято #{wagon.occupied_volume}"
      end
    end
  end

  def take_place
    train = train_selection
    wagon = wagon_selection(train)
    if train.class == TrainPassenger
      puts 'Сколько мест занять?'
      places = gets.chomp.to_i
      places.times {wagon.take_sit}
    elsif train.class == TrainCargo
      puts 'Какой объем занять?'
      volume = gets.chomp.to_i
      wagon.occupy_volume(volume)
    end
  end
end

Main.new().call
