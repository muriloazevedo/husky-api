# frozen_string_literal: true

module Serializable
  def as_json(options = {})
    serializer.new(serializable_object, options)
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def serializer_class(serializer)
      send(:define_method, :serializer) { serializer }
    end
  end
end
