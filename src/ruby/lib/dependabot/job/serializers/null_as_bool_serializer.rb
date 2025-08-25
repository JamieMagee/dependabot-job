# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'base_serializer'

module Dependabot
  module Job
    module Serializers
      # Serializer that converts null values to false for boolean properties
      class NullAsBoolSerializer < BaseSerializer
        extend T::Sig

        sig { override.params(value: T.untyped).returns(T::Boolean) }
        def deserialize(value)
          value.nil? ? false : !!value
        end

        sig { override.params(value: T::Boolean).returns(T::Boolean) }
        def serialize(value)
          value
        end

        # Convenience class method for direct usage
        sig { params(value: T.untyped).returns(T::Boolean) }
        def self.deserialize(value)
          new.deserialize(value)
        end
      end
    end
  end
end
