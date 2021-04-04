class WagonPassenger < TrainPassenger

  def inuitialize(amount)
    @amount = 1
  end

  def hook_in_wagon_passenger
    return if @speed != 0
    
    @amount += 1
  end

  def hook_out_wagon_passenger
    return unless @wagons > 1
    @wagons -= 1
  end

end
