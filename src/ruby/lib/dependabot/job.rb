# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'job/version'
require_relative 'job/models/job'
require_relative 'job/models/job_source'
require_relative 'job/models/dependency'
require_relative 'job/models/allowed_update'
require_relative 'job/models/dependency_group'
require_relative 'job/models/pull_request'
require_relative 'job/models/group_pull_request'
require_relative 'job/models/pull_request_dependency'
require_relative 'job/models/condition'
require_relative 'job/models/advisory'
require_relative 'job/models/commit_options'
require_relative 'job/models/cooldown'
require_relative 'job/models/enums/requirements_update_strategy'
require_relative 'job/models/enums/update_type'
require_relative 'job/serializers/base_serializer'
require_relative 'job/serializers/null_as_bool_serializer'
require_relative 'job/serializers/null_as_empty_array_serializer'
require_relative 'job/extensions/job_extensions'

module Dependabot
  # Dependabot Job library providing strongly-typed models for Dependabot job configurations.
  # This library includes models, serializers, and utility methods for working with
  # Dependabot job files and configurations with full Sorbet type checking support.
  module Job
    extend T::Sig

    class Error < StandardError; end

    # Convenience method for parsing JSON into a Job
    sig { params(json_string: String).returns(Models::Job) }
    def self.from_json(json_string)
      Models::Job.from_json(json_string)
    end

    # Convenience method for parsing hash into a Job
    sig { params(hash: T::Hash[Symbol, T.untyped]).returns(Models::Job) }
    def self.from_hash(hash)
      Models::Job.from_hash(hash)
    end
  end
end
