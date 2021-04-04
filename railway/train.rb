class Train

  attr_accessor :speed, :number

  attr_reader :wagons, :route, :station, :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @station = nil
  end

  def stop
    @speed = 0
  end

  def hook_in
    return if speed != 0
    @wagons += 1
  end

  def hook_out
    return unless @wagons > 1
    @wagons -= 1
  end

  def next_station
    current_station_index = route.stations.index(station)
    if current_station_index == (route.stations.length - 1)
      puts 'Вы на конечной станции'
      return
    end
    next_station_index = (current_station_index + 1)
    next_station = route.stations[next_station_index]
  end

  def previous_station
    current_station_index = route.stations.index(station)
    if current_station_index == 0
      puts 'Вы на начальной станции'
      return
    end
    previous_station_index = (current_station_index - 1)
    previous_station = route.stations[previous_station_index]
  end

  def current_station
    current_station = station
  end

  def move_previous_station
    return unless previous_station
    @station.send_train(self)
    @station = previous_station
    @station.get_train(self)
  end

  def route_take(route)
    @route = route
    station = route.initial
    station.get_train(self)
    @station = station
  end
end
