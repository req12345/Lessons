module Accessors
  class << self
    def self.included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods

  def attr_accessor_with_history(*attr)
    attr.each do |attr|
      var_name = "@#{attr}".to_sym

      define_method(attr) { instance_variable_get(var_name) }

      define_method("#{attr}_history") { instance_variable_get("@#{attr}_history") }

      define_method("#{attr}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history = instance_variable_get("@#{attr}_history") || []
        instance_variable_set("@#{attr}_history", history << value)
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)

    define_method(attr_name.to_sym) { instance_variable_get("@#{attr_name}".to_s) }

    define_method("#{attr_name}=") do |value|
      raise TypeError, "Type should be #{attr_class}" unless value.is_a?(attr_class)

      instance_variable_set("@#{attr_name}", value)
      end
    end
  end
end

class Test
  include Accessors

  attr_accessor_with_history :a, :b
  strong_attr_accessor :c, :d
end

t = Test.new
