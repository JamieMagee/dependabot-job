# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      module Enums
        # Represents the strategy for updating dependency requirements.
        class RequirementsUpdateStrategy < T::Enum
          enums do
            # Automatically determine the best strategy.
            Auto = new('auto')

            # Widen version ranges when possible.
            Widen = new('widen')

            # Increase version requirements to minimum supported.
            Increase = new('increase')

            # Increase version requirements only if required.
            IncreaseIfNecessary = new('increase_if_necessary')

            # Lock to exact version.
            LockfileOnly = new('lockfile_only')

            # Bump versions according to requirements.
            BumpVersions = new('bump_versions')
          end
        end
      end
    end
  end
end
