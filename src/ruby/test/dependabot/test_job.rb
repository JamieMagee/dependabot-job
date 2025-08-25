# typed: false
# frozen_string_literal: true

require 'test_helper'

module Dependabot
  class TestJob < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Dependabot::Job::VERSION
    end

    def test_module_can_parse_json
      json = '{"source": {"provider": "github"}}'
      job = Dependabot::Job.from_json(json)
      assert_equal 'github', job.source.provider
    end
  end
end
