
class Train

include Manufacturer
include InstanceCounter

NUMBER_FORMAT = /^[а-я a-z \d]{3}-*[а-я a-z \d]{2}$/i

  @@trains = []

  attr_accessor :speed, :number
  attr_reader :wagons, :route, :station, :type, :wagon

  def initialize(number, *wagons)
    @number = number
    @wagons = wagons
    @speed = 0
    @route = nil
    @station = nil
    @@trains << self
    validate!
    register_instance
  end
  # написать метод, который принимает блок и проходит по всем вагонам поезда
  # (вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.

  def trains_wagons
    @wagons.each {|wagon| yield wagon}
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.find(number)
    @@trains.select{|t| t.number == number}.first
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    return if speed != 0 && wagon.type != type
    @wagons << wagon
  end

  def detach_wagon(wagon)
    if @wagons.size != 0
      @wagons.delete(wagon)
    end
  end


  def move_previous_station
    return unless previous_station

    @station.send_train(self)
    @station = previous_station
    @station.get_train(self)
  end

  def move_next_station
    return unless next_station

    @station.send_train(self)
    @station = next_station
    @station.get_train(self)
  end

  def route_take(route)
    @route = route
    station = route.initial
    station.get_train(self)
    @station = station
    register_instance
  end

  private

  def validate!
    raise "Number can't be nil" if number.nil?
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end

  def next_station
    current_station_index = route.stations.index(station)
    if current_station_index == (route.stations.length - 1)
      return
    end
    next_station_index = (current_station_index + 1)
    route.stations[next_station_index]
  end

  def previous_station
    current_station_index = route.stations.index(station)
    return if current_station_index == 0

    previous_station_index = (current_station_index - 1)
    route.stations[previous_station_index]
  end

  def current_station
    station
  end
end
