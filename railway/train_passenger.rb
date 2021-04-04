class TrainPassanger < TrainPassenger

  def initialize(number,type)
  @number = number
  @type = 'passenger'
  @wagons_passenger = []
  end

end
