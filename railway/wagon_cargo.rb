class WagonCargo < Wagon

attr_reader :total_volume, :occupied_volume

  def initialize(number, total_volume)
    super
    @type = 'cargo'
    @total_volume = total_volume
    @occupied_volume = 0
  end

  def occupy_volume(volume)
    @occupied_volume = volume
  end

  def occupied_volume
    puts "#{@occupied_volume}"
  end

  def remaining_volume
    remaining_volume = @total_volume - @occupied_volume
    puts "#{remaining_volume}"
  end
end
