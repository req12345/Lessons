class WagonCargo < Wagon

attr_reader :total_volume, :occupied_volume


  def initialize(number, total_volume)
    
    @type = 'cargo'
    @total_volume = total_volume
    @occupied_volume = 0
    super(number)
  end

  def occupy_volume(volume)
    @occupied_volume = volume
  end

  def remaining_volume
    remaining_volume = @total_volume - @occupied_volume
    remaining_volume
  end
end
