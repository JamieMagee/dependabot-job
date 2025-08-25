using System.Collections.Immutable;

namespace Dependabot.Job;

/// <summary>
/// Represents a source configuration for a Dependabot job.
/// </summary>
public sealed record JobSource
{
  /// <summary>
  /// Gets or sets the provider (e.g., "github").
  /// </summary>
  public required string Provider { get; init; }

  /// <summary>
  /// Gets or sets the repository name.
  /// </summary>
  public string? Repo { get; init; }

  /// <summary>
  /// Gets or sets the primary directory to scan.
  /// </summary>
  public string? Directory { get; init; }

  /// <summary>
  /// Gets or sets additional directories to scan.
  /// </summary>
  public ImmutableArray<string>? Directories { get; init; }

  /// <summary>
  /// Gets or sets the branch name.
  /// </summary>
  public string? Branch { get; init; }

  /// <summary>
  /// Gets or sets the hostname.
  /// </summary>
  public string? Hostname { get; init; }

  /// <summary>
  /// Gets or sets the API endpoint.
  /// </summary>
  public string? ApiEndpoint { get; init; }
}
