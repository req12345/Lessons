class WagonCargo < TrainCargo

  def initialize(wagon)
    wagon = 1
  end

  def attach_wagon_cargo
    return if @speed != 0
    @wagons_cargo << wagon
    wagon += 1
    end

  def detach_wagon_cargo
    return unless @wagons_cargo.empty? == true || speed == 0
    @wagons_cargo.delete_at(-1)
  end
end
