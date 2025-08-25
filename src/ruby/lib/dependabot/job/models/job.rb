# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'json'
require_relative 'job_source'
require_relative 'allowed_update'
require_relative 'dependency_group'
require_relative 'pull_request'
require_relative 'group_pull_request'
require_relative 'condition'
require_relative 'advisory'
require_relative 'commit_options'
require_relative 'cooldown'
require_relative 'enums/requirements_update_strategy'
require_relative '../serializers/null_as_bool_serializer'
require_relative '../serializers/null_as_empty_array_serializer'
require_relative '../extensions/job_extensions'

module Dependabot
  module Job
    module Models
      # Represents a Dependabot job configuration.
      class Job < T::Struct
        include Extensions::JobExtensions
        extend T::Sig

        # The package manager (e.g., "bundler").
        const :package_manager, String, default: 'bundler'

        # The job source configuration.
        const :source, JobSource

        # The allowed updates configuration.
        const :allowed_updates, T::Array[AllowedUpdate], default: []

        # Whether debug mode is enabled.
        const :debug, T::Boolean, default: false

        # The dependency groups.
        const :dependency_groups, T::Array[DependencyGroup], default: []

        # The dependencies to update.
        const :dependencies, T::Array[String], default: []

        # The dependency group to refresh.
        const :dependency_group_to_refresh, T.nilable(String), default: nil

        # The existing pull requests.
        const :existing_pull_requests, T::Array[PullRequest], default: []

        # The existing group pull requests.
        const :existing_group_pull_requests, T::Array[GroupPullRequest], default: []

        # The experiments configuration.
        const :experiments, T.nilable(T::Hash[String, T.untyped]), default: nil

        # The ignore conditions.
        const :ignore_conditions, T::Array[Condition], default: []

        # Whether only lockfile updates are allowed.
        const :lockfile_only, T::Boolean, default: false

        # The requirements update strategy.
        const :requirements_update_strategy, T.nilable(Enums::RequirementsUpdateStrategy), default: nil

        # The security advisories.
        const :security_advisories, T::Array[Advisory], default: []

        # Whether only security updates are allowed.
        const :security_updates_only, T::Boolean, default: false

        # Whether subdependencies should be updated.
        const :update_subdependencies, T::Boolean, default: false

        # Whether this is updating an existing pull request.
        const :updating_a_pull_request, T::Boolean, default: false

        # Whether dependencies should be vendored.
        const :vendor_dependencies, T::Boolean, default: false

        # Whether external code should be rejected.
        const :reject_external_code, T::Boolean, default: false

        # Whether the repository is private.
        const :repo_private, T::Boolean, default: false

        # The commit message options.
        const :commit_message_options, T.nilable(CommitOptions), default: nil

        # The credentials metadata.
        const :credentials_metadata, T.nilable(T::Array[T::Hash[String, T.untyped]]), default: nil

        # The maximum updater run time in seconds.
        const :max_updater_run_time, Integer, default: 0

        # The cooldown configuration.
        const :cooldown, T.nilable(Cooldown), default: nil

        # JSON serialization
        sig { params(json_string: String).returns(Job) }
        def self.from_json(json_string)
          data = JSON.parse(json_string, symbolize_names: true)
          from_hash(data)
        end

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(Job) }
        def self.from_hash(hash)
          # Parse allowed updates
          allowed_updates = Array(hash[:allowed_updates] || []).map do |update_hash|
            AllowedUpdate.from_hash(update_hash)
          end

          # Parse dependency groups
          dependency_groups = Array(hash[:dependency_groups] || []).map do |group_hash|
            DependencyGroup.from_hash(group_hash)
          end

          # Parse existing pull requests
          existing_pull_requests = Array(hash[:existing_pull_requests] || []).map do |pr_hash|
            PullRequest.from_hash(pr_hash)
          end

          # Parse existing group pull requests
          existing_group_pull_requests = Array(hash[:existing_group_pull_requests] || []).map do |gpr_hash|
            GroupPullRequest.from_hash(gpr_hash)
          end

          # Parse ignore conditions
          ignore_conditions = Array(hash[:ignore_conditions] || []).map do |condition_hash|
            Condition.from_hash(condition_hash)
          end

          # Parse security advisories
          security_advisories = Array(hash[:security_advisories] || []).map do |advisory_hash|
            Advisory.from_hash(advisory_hash)
          end

          # Parse requirements update strategy
          requirements_update_strategy = if hash[:requirements_update_strategy]
                                           Enums::RequirementsUpdateStrategy.deserialize(hash[:requirements_update_strategy])
                                         end

          # Parse commit message options
          commit_message_options = if hash[:commit_message_options]
                                     CommitOptions.from_hash(hash[:commit_message_options])
                                   end

          # Parse cooldown
          cooldown = (Cooldown.from_hash(hash[:cooldown]) if hash[:cooldown])

          new(
            package_manager: hash.fetch(:package_manager, 'bundler'),
            source: JobSource.from_hash(hash.fetch(:source)),
            allowed_updates: allowed_updates,
            debug: Serializers::NullAsBoolSerializer.deserialize(hash[:debug]),
            dependency_groups: dependency_groups,
            dependencies: Serializers::NullAsEmptyArraySerializer.deserialize(hash[:dependencies]),
            dependency_group_to_refresh: hash[:dependency_group_to_refresh],
            existing_pull_requests: existing_pull_requests,
            existing_group_pull_requests: existing_group_pull_requests,
            experiments: hash[:experiments],
            ignore_conditions: ignore_conditions,
            lockfile_only: !hash[:lockfile_only].nil?,
            requirements_update_strategy: requirements_update_strategy,
            security_advisories: security_advisories,
            security_updates_only: !hash[:security_updates_only].nil?,
            update_subdependencies: !hash[:update_subdependencies].nil?,
            updating_a_pull_request: !hash[:updating_a_pull_request].nil?,
            vendor_dependencies: !hash[:vendor_dependencies].nil?,
            reject_external_code: !hash[:reject_external_code].nil?,
            repo_private: !hash[:repo_private].nil?,
            commit_message_options: commit_message_options,
            credentials_metadata: hash[:credentials_metadata],
            max_updater_run_time: hash.fetch(:max_updater_run_time, 0),
            cooldown: cooldown
          )
        end

        sig { params(_args: T.untyped).returns(String) }
        def to_json(*_args)
          to_hash.to_json
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            package_manager: package_manager,
            source: source.to_hash,
            allowed_updates: allowed_updates.map(&:to_hash),
            debug: debug,
            dependency_groups: dependency_groups.map(&:to_hash),
            dependencies: dependencies,
            dependency_group_to_refresh: dependency_group_to_refresh,
            existing_pull_requests: existing_pull_requests.map(&:to_hash),
            existing_group_pull_requests: existing_group_pull_requests.map(&:to_hash),
            experiments: experiments,
            ignore_conditions: ignore_conditions.map(&:to_hash),
            lockfile_only: lockfile_only,
            requirements_update_strategy: requirements_update_strategy&.serialize,
            security_advisories: security_advisories.map(&:to_hash),
            security_updates_only: security_updates_only,
            update_subdependencies: update_subdependencies,
            updating_a_pull_request: updating_a_pull_request,
            vendor_dependencies: vendor_dependencies,
            reject_external_code: reject_external_code,
            repo_private: repo_private,
            commit_message_options: commit_message_options&.to_hash,
            credentials_metadata: credentials_metadata,
            max_updater_run_time: max_updater_run_time,
            cooldown: cooldown&.to_hash
          }.compact
        end
      end
    end
  end
end
