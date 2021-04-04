class WagonPassenger < TrainPassenger

  def inuitialize
    @amount = 1
  end

  def hook_in_wagon_passenger
    return if @speed != 0
    @wagons_passenger << @amount
    @amount += 1
  end

  def hook_out_wagon_passenger
    return unless @amount > 1
    @amount -= 1
  end

end
