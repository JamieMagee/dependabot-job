# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents a source configuration for a Dependabot job.
      class JobSource < T::Struct
        extend T::Sig

        # The provider (e.g., "github").
        const :provider, String

        # The repository name.
        const :repo, T.nilable(String), default: nil

        # The primary directory to scan.
        const :directory, T.nilable(String), default: nil

        # Additional directories to scan.
        const :directories, T.nilable(T::Array[String]), default: nil

        # The branch name.
        const :branch, T.nilable(String), default: nil

        # The hostname.
        const :hostname, T.nilable(String), default: nil

        # The API endpoint.
        const :api_endpoint, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(JobSource) }
        def self.from_hash(hash)
          new(
            provider: hash.fetch(:provider),
            repo: hash[:repo],
            directory: hash[:directory],
            directories: hash[:directories],
            branch: hash[:branch],
            hostname: hash[:hostname],
            api_endpoint: hash[:api_endpoint]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            provider: provider,
            repo: repo,
            directory: directory,
            directories: directories,
            branch: branch,
            hostname: hostname,
            api_endpoint: api_endpoint
          }.compact
        end
      end
    end
  end
end
