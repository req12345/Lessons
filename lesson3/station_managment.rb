#Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских

class Station  #Класс Station (Станция)

  #Может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :trains

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
  def send_train(name)
    @trains.delete(name)
  end
end

class Route #Класс Route (Маршрут)

  #Имеет начальную и конечную станцию, а также список промежуточных станций.
  #начальная и конечная станции указываютсся при создании маршрута, а
  #промежуточные могут добавляться между ними.
  def initialize(initial, final)
    @initial = initial #начальная
    @final = final #конечная
    @intermediate_sation = []
  end

  #Может добавлять промежуточную станцию в список
  def add_station(name)
    @intermediate_sation << name
  end

  #Может удалять промежуточную станцию из списка
  def delete_station(name)
    @intermediate_sation.delete(name)
  end

  #Может выводить список всех станций по-порядку от начальной до конечной
  def stations
    puts "Station list: #{initial}, #{@intermediate_station}, #{final}"
  end
end

class Train #Класс Train (Поезд)

  #Может возвращать текущую скорость #Может набирать скорость
  attr_accessor :speed
  # Может возвращать количество вагонов
  attr_reader :wagons

  #Имеет номер (произвольная строка) и  и количество вагонов,
  #эти данные указываются при создании экземпляра класса
  #тип (грузовой, пассажирский) - РАЗОБРАТЬСЯ
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  #Может тормозить (сбрасывать скорость до нуля)
  def stop(speed)
    @speed = 0
  end

  #Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
  #метод просто увеличивает или уменьшает количество вагонов)
  #Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def hook_in_out(num)
    if num > 0 && @speed == 0
      @wagons += 1
    elsif
      @wagons >0 && num < 0 && speed == 0
      @wagons -= 1
    else
      puts "enter '+1' or '-1'"
    end
  end

  #может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def near_stations
    puts "previous station is"
    puts "current station is"
    puts "next station is"
  end

  #Может принимать маршрут следования (объект класса Route).
  #При назначении маршрута поезду, поезд автоматически помещается на первую
  #станцию в маршруте.
  def route_take

  end
end
