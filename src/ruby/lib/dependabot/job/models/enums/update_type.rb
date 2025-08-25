# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      module Enums
        # Represents the type of update allowed for dependencies.
        class UpdateType < T::Enum
          enums do
            # Security updates only.
            Security = new('security')

            # Version updates including patch, minor, and major versions.
            Version = new('version')

            # All types of updates.
            All = new('all')
          end
        end
      end
    end
  end
end
