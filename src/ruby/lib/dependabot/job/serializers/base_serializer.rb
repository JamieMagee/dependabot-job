# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Serializers
      # Base class for custom serializers
      class BaseSerializer
        extend T::Sig
        extend T::Helpers
        abstract!

        sig { abstract.params(value: T.untyped).returns(T.untyped) }
        def serialize(value); end

        sig { abstract.params(value: T.untyped).returns(T.untyped) }
        def deserialize(value); end
      end
    end
  end
end
