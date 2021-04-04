class WagonPassenger < TrainPassenger

  def initialize(wagon)
    wagon = 1
  end

  def attach_wagon_passenger
    return if @speed != 0
    @wagons_passenger << wagon
    wagon += 1
    end

  def detach_wagon_passenger
    return unless @wagons_passenger.empty? == true || speed == 0
    @wagons_passenger.delete_at(-1)
  end

end
