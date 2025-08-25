# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents a dependency group configuration.
      class DependencyGroup < T::Struct
        extend T::Sig

        # The name of the dependency group.
        const :name, String

        # What this group applies to (e.g., "version-updates", "security-updates").
        const :applies_to, T.nilable(String), default: nil

        # The dependency type.
        const :dependency_type, T.nilable(String), default: nil

        # The update types allowed for this group.
        const :update_types, T::Array[String], default: []

        # The patterns for dependencies to include.
        const :patterns, T::Array[String], default: []

        # The patterns for dependencies to exclude.
        const :exclude_patterns, T::Array[String], default: []

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(DependencyGroup) }
        def self.from_hash(hash)
          new(
            name: hash.fetch(:name),
            applies_to: hash[:applies_to],
            dependency_type: hash[:dependency_type],
            update_types: Array(hash[:update_types] || []),
            patterns: Array(hash[:patterns] || []),
            exclude_patterns: Array(hash[:exclude_patterns] || [])
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            name: name,
            applies_to: applies_to,
            dependency_type: dependency_type,
            update_types: update_types,
            patterns: patterns,
            exclude_patterns: exclude_patterns
          }.compact
        end
      end
    end
  end
end
