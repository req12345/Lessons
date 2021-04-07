class Route

  attr_reader :intermediate_station, :initial, :stations

  def initialize(initial, final)
    @initial = initial
    @final = final
    @intermediate_station = []
  end

  def add_station(station)
    @intermediate_station << station
  end

  def delete_station(name)
    @intermediate_station.delete(name)
  end

  def stations
    stations = [@initial, *@intermediate_station, @final]
  end
end
