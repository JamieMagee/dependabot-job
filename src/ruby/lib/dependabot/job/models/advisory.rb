# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Dependabot
  module Job
    module Models
      # Represents a security advisory.
      class Advisory < T::Struct
        extend T::Sig

        # The advisory identifier.
        const :id, String

        # The advisory title.
        const :title, T.nilable(String), default: nil

        # The advisory description.
        const :description, T.nilable(String), default: nil

        # The severity level.
        const :severity, T.nilable(String), default: nil

        # The CVE identifier.
        const :cve_id, T.nilable(String), default: nil

        # The GHSA identifier.
        const :ghsa_id, T.nilable(String), default: nil

        # The affected package name.
        const :package_name, T.nilable(String), default: nil

        # The affected version range.
        const :affected_versions, T.nilable(String), default: nil

        # The patched version range.
        const :patched_versions, T.nilable(String), default: nil

        sig { params(hash: T::Hash[Symbol, T.untyped]).returns(Advisory) }
        def self.from_hash(hash)
          new(
            id: hash.fetch(:id),
            title: hash[:title],
            description: hash[:description],
            severity: hash[:severity],
            cve_id: hash[:cve_id],
            ghsa_id: hash[:ghsa_id],
            package_name: hash[:package_name],
            affected_versions: hash[:affected_versions],
            patched_versions: hash[:patched_versions]
          )
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_hash
          {
            id: id,
            title: title,
            description: description,
            severity: severity,
            cve_id: cve_id,
            ghsa_id: ghsa_id,
            package_name: package_name,
            affected_versions: affected_versions,
            patched_versions: patched_versions
          }.compact
        end
      end
    end
  end
end
