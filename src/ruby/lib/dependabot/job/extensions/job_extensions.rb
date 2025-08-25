# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Extensions
      # Extension methods for the Job class.
      module JobExtensions
        extend T::Sig

        # Gets all directories to scan for dependencies.
        sig { returns(T::Array[String]) }
        def all_directories
          directories = []
          job_source = T.cast(self, Dependabot::Job::Models::Job).source
          directories << job_source.directory if job_source.directory
          directories.concat(job_source.directories || [])
          directories = directories.uniq
          directories.empty? ? ['/'] : directories
        end

        # Gets dependency groups filtered by the specified type.
        sig { params(filter_type: T.nilable(String)).returns(T::Array[Dependabot::Job::Models::DependencyGroup]) }
        def relevant_dependency_groups(filter_type = nil)
          job_dependency_groups = T.cast(self, Dependabot::Job::Models::Job).dependency_groups
          job_security_only = T.cast(self, Dependabot::Job::Models::Job).security_updates_only

          # If no filter type specified, use security mode
          actual_filter = filter_type || (job_security_only ? 'security-updates' : 'version-updates')

          job_dependency_groups.select { |group| group.applies_to == actual_filter }
        end

        # Determines whether a dependency is ignored by name only.
        sig { params(dependency_name: String).returns(T::Boolean) }
        def dependency_ignored_by_name_only?(dependency_name)
          job_ignore_conditions = T.cast(self, Dependabot::Job::Models::Job).ignore_conditions

          job_ignore_conditions.any? do |condition|
            # Check if dependency name matches the pattern and no version requirement
            matches_pattern = if condition.dependency_name.include?('*')
                                # Convert glob pattern to regex
                                pattern = condition.dependency_name.gsub('*', '.*')
                                dependency_name.match?(/\A#{pattern}\z/)
                              else
                                condition.dependency_name == dependency_name
                              end

            matches_pattern && condition.version_requirement.nil?
          end
        end

        # Gets all dependencies that match the pull request dependency names.
        sig do
          params(pull_request: Dependabot::Job::Models::PullRequest)
            .returns(T::Array[String])
        end
        def dependencies_for_pull_request(pull_request)
          job_dependencies = T.cast(self, Dependabot::Job::Models::Job).dependencies

          pr_dep_names = pull_request.dependencies.map(&:dependency_name)
          job_dependencies.select { |dep| pr_dep_names.include?(dep) }
        end

        # Determines whether security updates only mode is enabled.
        sig { returns(T::Boolean) }
        def security_updates_only?
          T.cast(self, Dependabot::Job::Models::Job).security_updates_only
        end

        # Gets the primary directory for the job.
        sig { returns(String) }
        def primary_directory
          job_source = T.cast(self, Dependabot::Job::Models::Job).source
          job_source.directory || '/'
        end

        # Gets unique dependency names.
        sig { returns(T::Array[String]) }
        def dependency_names
          job_dependencies = T.cast(self, Dependabot::Job::Models::Job).dependencies
          job_dependencies.uniq
        end

        # Determines whether the job has ignore conditions.
        sig { returns(T::Boolean) }
        def ignore_conditions?
          job_ignore_conditions = T.cast(self, Dependabot::Job::Models::Job).ignore_conditions
          !job_ignore_conditions.empty?
        end

        # Determines whether the job has dependency groups.
        sig { returns(T::Boolean) }
        def dependency_groups?
          job_dependency_groups = T.cast(self, Dependabot::Job::Models::Job).dependency_groups
          !job_dependency_groups.empty?
        end

        # Gets the repository name.
        sig { returns(String) }
        def repository_name
          job_source = T.cast(self, Dependabot::Job::Models::Job).source
          job_source.repo || 'unknown/repository'
        end

        # Determines the job category based on package manager.
        sig { returns(String) }
        def job_category
          package_manager = T.cast(self, Dependabot::Job::Models::Job).package_manager
          categorize_by_package_manager(package_manager)
        end

        private

        sig { params(package_manager: String).returns(String) }
        def categorize_by_package_manager(package_manager)
          case package_manager
          when 'bundler', 'npm_and_yarn', 'yarn', 'pip', 'composer'
            'language'
          when 'docker', 'terraform'
            'infrastructure'
          when 'github_actions'
            'ci_cd'
          else
            'other'
          end
        end
      end
    end
  end
end
