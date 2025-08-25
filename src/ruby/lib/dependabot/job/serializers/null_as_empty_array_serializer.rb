# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'base_serializer'

module Dependabot
  module Job
    module Serializers
      # Serializer that converts null values to empty arrays
      class NullAsEmptyArraySerializer < BaseSerializer
        extend T::Sig

        sig { override.params(value: T.untyped).returns(T::Array[String]) }
        def deserialize(value)
          value.nil? ? [] : Array(value)
        end

        sig { override.params(value: T::Array[String]).returns(T::Array[String]) }
        def serialize(value)
          value
        end

        # Convenience class method for direct usage
        sig { params(value: T.untyped).returns(T::Array[String]) }
        def self.deserialize(value)
          new.deserialize(value)
        end
      end
    end
  end
end
