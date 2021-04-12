module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods

  end
  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end
  end

private

  module InstanceMethods
    @instances = 0

  def register_instance
    @instances += 1
  end

  attr_accessor :register_instance
end
# Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически
# при вызове include в классе:
# Методы класса:
#        - instances, который возвращает кол-во экземпляров данного класса
# Инстанс-методы:

#        - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора.
#        При этом данный метод не должен быть публичным.

# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансев базового класса.
