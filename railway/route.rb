class Route

include InstanceCounter

  attr_reader :intermediate_station, :final, :initial, :stations

  def initialize(initial, final)
    @initial = initial
    @final = final
    @intermediate_station = []
    register_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
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

  private

  def validate!
    raise "Route should have initial station" if initial.nil?
    raise "Route should have final station" if final.nil?
  end
end
