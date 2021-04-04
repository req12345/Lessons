class TrainCargo < Train

  def initialize(number,type)
  @number = number
  @type = 'cargo'
  @wagons_cargo = []
  end
end
