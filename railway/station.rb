class Station

include InstanceCounter

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    @@instances +=1
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
end
