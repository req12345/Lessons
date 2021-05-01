# аписать метод, который принимает блок и проходит по всем поездам
# на станции, передавая каждый поезд в блок.

class Station

include InstanceCounter

  @@stations = []

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
  end


  def trains_on_station
    @trains.each {|train| yield train}
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @@stations
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type
    trains_list = { 'cargo': [], 'passanger': [] }
    trains.each do |train|
      trains_list[train.type.to_sym] << train
    end
    puts "Пассажирские поезда: #{trains_list[:passanger].map(&:number).join(', ')}"
    puts "Всего:  #{trains_list[:passanger].size}"

    puts "Грузовые поезда: #{trains_list[:cargo].map(&:number).join(', ')}"
    puts "Всего:  #{trains_list[:cargo].size}"
  end

  private

  def validate!
    raise "Name can't be nil" if name.nil?
    raise 'Name should be at least 2 symbols' if name.length < 2
  end
end
