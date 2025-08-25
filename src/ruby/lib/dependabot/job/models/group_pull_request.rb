# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative 'pull_request_dependency'

module Dependabot
  module Job
    module Models
      # Represents an existing group pull request.
      class GroupPullRequest < T::Struct
        extend T::Sig

        # The name of the dependency group.
        const :dependency_group_name, T.nilable(String), default: nil

        # The dependencies included in this group pull request.
        const :dependencies, T::Array[PullRequestDependency], default: []

        # The pull request number.
        const :number, T.nilable(Integer), default: nil

        # The pull request URL.
        const :url, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(GroupPullRequest) }
        def self.from_hash(hash)
          dependencies = Array(hash[:dependencies] || []).map do |dep_hash|
            PullRequestDependency.from_hash(dep_hash)
          end

          new(
            dependency_group_name: hash[:dependency_group_name],
            dependencies: dependencies,
            number: hash[:number],
            url: hash[:url]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            dependency_group_name: dependency_group_name,
            dependencies: dependencies.map(&:to_hash),
            number: number,
            url: url
          }.compact
        end
      end
    end
  end
end
