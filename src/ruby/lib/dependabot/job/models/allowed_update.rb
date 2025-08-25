# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'enums/update_type'

module Dependabot
  module Job
    module Models
      # Represents an allowed update configuration for dependencies.
      class AllowedUpdate < T::Struct
        extend T::Sig

        # The type of update allowed.
        const :update_type, Enums::UpdateType, default: Enums::UpdateType::All

        # The dependency name pattern (supports wildcards).
        const :dependency_name, T.nilable(String), default: nil

        # The dependency type.
        const :dependency_type, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(AllowedUpdate) }
        def self.from_hash(hash)
          update_type = if hash[:update_type]
                          Enums::UpdateType.deserialize(hash[:update_type])
                        else
                          Enums::UpdateType::All
                        end

          new(
            update_type: update_type,
            dependency_name: hash[:dependency_name],
            dependency_type: hash[:dependency_type]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            update_type: update_type.serialize,
            dependency_name: dependency_name,
            dependency_type: dependency_type
          }.compact
        end
      end
    end
  end
end
