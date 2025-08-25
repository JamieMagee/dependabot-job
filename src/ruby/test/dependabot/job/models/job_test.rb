# typed: false
# frozen_string_literal: true

require 'test_helper'

class JobTest < Minitest::Test
  def setup
    @fixture_path = File.expand_path('../fixtures/job_example.json', __dir__)
    @job_json = File.read(@fixture_path)
  end

  def test_job_deserializes_from_json
    job = Dependabot::Job.from_json(@job_json)

    assert_equal 'bundler', job.package_manager
    assert_equal false, job.debug # null should be converted to false
    assert_equal [], job.dependencies # null should be converted to empty array
    assert_equal 'github', job.source.provider
    assert_equal 'test/repo', job.source.repo
    assert_equal '/src', job.source.directory
  end

  def test_job_serializes_to_json
    job = Dependabot::Job.from_json(@job_json)
    serialized = job.to_json
    parsed = JSON.parse(serialized, symbolize_names: true)

    assert_equal 'bundler', parsed[:package_manager]
    assert_equal 'github', parsed[:source][:provider]
    assert_equal false, parsed[:debug]
    assert_equal [], parsed[:dependencies]
  end

  def test_job_from_hash
    hash = {
      package_manager: 'npm',
      source: {
        provider: 'github',
        repo: 'example/repo'
      }
    }

    job = Dependabot::Job.from_hash(hash)

    assert_equal 'npm', job.package_manager
    assert_equal 'github', job.source.provider
    assert_equal 'example/repo', job.source.repo
  end

  def test_job_with_minimal_data
    hash = {
      source: {
        provider: 'github'
      }
    }

    job = Dependabot::Job.from_hash(hash)

    assert_equal 'bundler', job.package_manager # default value
    assert_equal 'github', job.source.provider
    assert_equal false, job.debug # default value
    assert_equal [], job.dependencies # default value
  end

  def test_job_to_hash
    job = Dependabot::Job::Models::Job.new(
      package_manager: 'bundler',
      source: Dependabot::Job::Models::JobSource.new(
        provider: 'github',
        repo: 'test/repo',
        directory: '/src'
      )
    )

    hash = job.to_hash

    assert_equal 'bundler', hash[:package_manager]
    assert_equal 'github', hash[:source][:provider]
    assert_equal 'test/repo', hash[:source][:repo]
    assert_equal '/src', hash[:source][:directory]
  end
end
