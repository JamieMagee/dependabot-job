# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'pull_request_dependency'

module Dependabot
  module Job
    module Models
      # Represents an existing pull request.
      class PullRequest < T::Struct
        extend T::Sig

        # The dependencies included in this pull request.
        const :dependencies, T::Array[PullRequestDependency], default: []

        # The pull request number.
        const :number, T.nilable(Integer), default: nil

        # The pull request URL.
        const :url, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(PullRequest) }
        def self.from_hash(hash)
          dependencies = Array(hash[:dependencies] || []).map do |dep_hash|
            PullRequestDependency.from_hash(dep_hash)
          end

          new(
            dependencies: dependencies,
            number: hash[:number],
            url: hash[:url]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            dependencies: dependencies.map(&:to_hash),
            number: number,
            url: url
          }.compact
        end
      end
    end
  end
end
