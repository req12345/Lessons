
class Station  #Класс Station (Станция)
  #Может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :trains, :name

  #Имеет название, которое указывается при ее создании
  def initialize(name)
    @name = name #название поезда
    @trains = [] #список поездов
  end

  #Может принимать поезда (по одному за раз)
  def get_train(train)
    @trains << train
  end

  #Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train)
    @trains.delete(train)
  end

  # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_by_type
    trains_list = { 'cargo': [], 'passanger': [] }
    trains.each do |train|
      trains_list[train.type.to_sym] << train
    end
    puts "Пассажирские поезда: #{trains_list[:passanger].map(&:number).join(', ')}"
    puts "Всего:  #{trains_list[:passanger].size}"

    puts "Грузовые поезда: #{trains_list[:cargo].map(&:number).join(', ')}"
    puts "Всего:  #{trains_list[:cargo].size}"
  end
end

class Route #Класс Route (Маршрут)
  attr_reader :intermediate_station, :initial, :stations
  #Имеет начальную и конечную станцию, а также список промежуточных станций.
  #начальная и конечная станции указываютсся при создании маршрута, а
  #промежуточные могут добавляться между ними.
  def initialize(initial, final)
    @initial = initial #начальная
    @final = final #конечная
    @intermediate_station = []
  end

  #Может добавлять промежуточную станцию в список
  def add_station(station)
    @intermediate_station << station
  end

  #Может удалять промежуточную станцию из списка
  def delete_station(name)
    @intermediate_sation.delete(name)
  end

  #Может выводить список всех станций по-порядку от начальной до конечной
  def stations
    stations = [@initial, *@intermediate_station, @final]
  end
end

class Train #Класс Train (Поезд)
  #Может возвращать текущую скорость #Может набирать скорость
  attr_accessor :speed, :number
  # Может возвращать количество вагонов
  attr_reader :wagons, :route, :station, :type

  #Имеет номер (произвольная строка) и  и количество вагонов,
  #эти данные указываются при создании экземпляра класса
  #тип (грузовой, пассажирский) - РАЗОБРАТЬСЯ
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @station = nil
  end

  #Может тормозить (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

  #Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
  #метод просто увеличивает или уменьшает количество вагонов)
  #Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def hook_in
    return if speed != 0
    @wagons += 1
  end

  def hook_out
    return unless @wagons > 1
    @wagons -= 1
  end


  # Может перемещаться между станциями, указанными в маршруте.
  # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  # Определить индекс текущей станции в маршруте
  # Проверка на последнюю станцию
  def move_next
    current_station_index = route.stations.index(station)
    next_station_index = (current_station_index + 1)
    if next_station_index > (route.stations.length - 1)
      puts 'Нельзя!'
      return
    end
    @station.send_train(self)
    next_station = route.stations[next_station_index]
    @station = next_station
    @station.get_train(self)
  end

  def move_back
    current_station_index = route.stations.index(station)
    previous_station_index = (current_station_index - 1)
    if previous_station_index == 0
      puts 'Нельзя!'
      return
    end
    @station.send_train(self)
    previous_station = route.stations[previous_station_index]
    @station = previous_station
    @station.get_train(self)
  end

  #может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def near_stations
    current_index = route.stations.index(station)
    previous_index = current_index - 1
    next_index = current_index + 1

    puts "previous station is #{route.stations[previous_index]}"
    puts "current station is #{route.stations[current_index]}"
    puts "next station is #{route.stations[next_index]}"
  end

  #Может принимать маршрут следования (объект класса Route).
  #При назначении маршрута поезду, поезд автоматически помещается на первую
  #станцию в маршруте.
  def route_take(route)
    @route = route

    station = route.initial # Нашли станцию
    station.get_train(self) # Станция принимает поезд (метод станции)

    @station = station
  end
end
