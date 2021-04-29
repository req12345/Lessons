class WagonPassenger < Wagon

attr_reader :occupied_sits, :free_sits

  def initialize(number, total_sits)
    super
    @type = 'passanger'
    @total_sits = total_sits
    @occupied_sits = 0
  end

  def take_sit
    @occupied_sits += 1
  end

  def occupied_sits
    puts "#{@occupied_sits}"
  end

  def vacanted_sits
    vacanted_sits = @total_sits - @occupied_sits
    vacanted_sits
  end
end
