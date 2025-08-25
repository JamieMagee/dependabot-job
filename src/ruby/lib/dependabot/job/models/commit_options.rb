# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents commit message options for pull requests.
      class CommitOptions < T::Struct
        extend T::Sig

        # The commit message prefix.
        const :prefix, T.nilable(String), default: nil

        # Whether to include a scope in commit messages.
        const :include_scope, T.nilable(T::Boolean), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(CommitOptions) }
        def self.from_hash(hash)
          new(
            prefix: hash[:prefix],
            include_scope: hash[:include_scope]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            prefix: prefix,
            include_scope: include_scope
          }.compact
        end
      end
    end
  end
end
