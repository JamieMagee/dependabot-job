# typed: false
# frozen_string_literal: true

require 'test_helper'

class JobExtensionsTest < Minitest::Test
  def setup
    @job = Dependabot::Job::Models::Job.new(
      source: Dependabot::Job::Models::JobSource.new(
        provider: 'github',
        directory: '/src',
        directories: ['/test', '/docs']
      ),
      security_updates_only: false,
      dependency_groups: [
        Dependabot::Job::Models::DependencyGroup.new(
          name: 'security',
          applies_to: 'security-updates'
        ),
        Dependabot::Job::Models::DependencyGroup.new(
          name: 'version',
          applies_to: 'version-updates'
        )
      ],
      ignore_conditions: [
        Dependabot::Job::Models::Condition.new(
          dependency_name: 'System.*',
          update_types: [],
          version_requirement: nil
        )
      ]
    )
  end

  def test_all_directories_returns_source_and_additional_directories
    directories = @job.all_directories

    assert_equal ['/src', '/test', '/docs'], directories
  end

  def test_all_directories_returns_root_when_no_directories
    job = Dependabot::Job::Models::Job.new(
      source: Dependabot::Job::Models::JobSource.new(provider: 'github')
    )

    directories = job.all_directories

    assert_equal ['/'], directories
  end

  def test_relevant_dependency_groups_filters_by_security_updates
    job_security = Dependabot::Job::Models::Job.new(
      source: Dependabot::Job::Models::JobSource.new(provider: 'github'),
      security_updates_only: true,
      dependency_groups: @job.dependency_groups
    )

    groups = job_security.relevant_dependency_groups

    assert_equal 1, groups.length
    assert_equal 'security', groups.first.name
  end

  def test_relevant_dependency_groups_filters_by_version_updates
    groups = @job.relevant_dependency_groups

    assert_equal 1, groups.length
    assert_equal 'version', groups.first.name
  end

  def test_dependency_ignored_by_name_only_returns_true_for_ignored_dependency
    result = @job.dependency_ignored_by_name_only?('System.Text.Json')

    assert result
  end

  def test_dependency_ignored_by_name_only_returns_false_for_non_ignored_dependency
    result = @job.dependency_ignored_by_name_only?('Newtonsoft.Json')

    refute result
  end
end
