# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents cooldown settings for Dependabot operations.
      class Cooldown < T::Struct
        extend T::Sig

        # The cooldown duration in minutes.
        const :duration, Integer

        # The reason for the cooldown.
        const :reason, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(Cooldown) }
        def self.from_hash(hash)
          new(
            duration: hash.fetch(:duration),
            reason: hash[:reason]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            duration: duration,
            reason: reason
          }.compact
        end
      end
    end
  end
end
