# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents a dependency in a pull request.
      class PullRequestDependency < T::Struct
        extend T::Sig

        # The name of the dependency.
        const :dependency_name, String

        # The version of the dependency.
        const :dependency_version, String

        # The directory where the dependency is located.
        const :directory, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PullRequestDependency) }
        def self.from_hash(hash)
          new(
            dependency_name: hash.fetch(:dependency_name),
            dependency_version: hash.fetch(:dependency_version).to_s,
            directory: hash[:directory]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            dependency_name: dependency_name,
            dependency_version: dependency_version,
            directory: directory
          }.compact
        end
      end
    end
  end
end
