using System.Collections.Immutable;

namespace Dependabot.Job;

/// <summary>
/// Represents a dependency in the context of a Dependabot job.
/// </summary>
public sealed record Dependency
{
  /// <summary>
  /// Gets or sets the name of the dependency.
  /// </summary>
  public required string Name { get; init; }

  /// <summary>
  /// Gets or sets the current version of the dependency.
  /// </summary>
  public string? Version { get; init; }

  /// <summary>
  /// Gets or sets the requirements for the dependency.
  /// </summary>
  public ImmutableArray<string> Requirements { get; init; } = [];

  /// <summary>
  /// Gets or sets the groups this dependency belongs to.
  /// </summary>
  public ImmutableArray<string> Groups { get; init; } = [];

  /// <summary>
  /// Gets or sets the source of the dependency.
  /// </summary>
  public string? Source { get; init; }

  /// <summary>
  /// Gets or sets a value indicating whether this is a transitive dependency.
  /// </summary>
  public bool IsTransitive { get; init; }
}
