# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents a dependency in the context of a Dependabot job.
      class Dependency < T::Struct
        extend T::Sig

        # The name of the dependency.
        const :name, String

        # The current version of the dependency.
        const :version, T.nilable(String), default: nil

        # The requirements for the dependency.
        const :requirements, T::Array[String], default: []

        # The groups this dependency belongs to.
        const :groups, T::Array[String], default: []

        # The source of the dependency.
        const :source, T.nilable(String), default: nil

        # Whether this is a transitive dependency.
        const :is_transitive, T::Boolean, default: false

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(Dependency) }
        def self.from_hash(hash)
          new(
            name: hash.fetch(:name),
            version: hash[:version],
            requirements: Array(hash[:requirements] || []),
            groups: Array(hash[:groups] || []),
            source: hash[:source],
            is_transitive: !hash[:is_transitive].nil?
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            name: name,
            version: version,
            requirements: requirements,
            groups: groups,
            source: source,
            is_transitive: is_transitive
          }.compact
        end
      end
    end
  end
end
