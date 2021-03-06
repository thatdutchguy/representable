require "representable/deserializer"

module Representable
  class ObjectSerializer < ObjectDeserializer
    def call # TODO: make typed? switch here!
      return @object if @object.nil?

      representable = prepare(@object)

      serialize(representable, @binding.user_options)
    end

  private
    def serialize(object, user_options)
      # TODO: this used to be handled in #serialize where Object added it's behaviour. treat scalars as objects to remove this switch:
      return object unless @binding.typed?

      object.send(@binding.serialize_method, user_options.merge!({:wrap => false}))
    end
  end
end