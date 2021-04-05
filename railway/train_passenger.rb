class TrainPassanger < Train

  def initialize(number, *wagons)
    @type = 'passanger'
    super
  end
end
