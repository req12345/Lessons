class TrainPassenger < Train

  def initialize(number, *wagons)
    @type = 'passenger'
    super
  end
end
