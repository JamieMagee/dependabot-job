# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents a condition for ignoring dependencies.
      class Condition < T::Struct
        extend T::Sig

        # The dependency name pattern.
        const :dependency_name, String

        # The version requirement.
        const :version_requirement, T.nilable(String), default: nil

        # The update types to ignore.
        const :update_types, T::Array[String], default: []

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(Condition) }
        def self.from_hash(hash)
          new(
            dependency_name: hash.fetch(:dependency_name),
            version_requirement: hash[:version_requirement],
            update_types: Array(hash[:update_types] || [])
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            dependency_name: dependency_name,
            version_requirement: version_requirement,
            update_types: update_types.empty? ? nil : update_types
          }.compact
        end
      end
    end
  end
end
