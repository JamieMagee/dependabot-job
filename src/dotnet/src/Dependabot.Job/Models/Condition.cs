using System.Collections.Immutable;

namespace Dependabot.Job;

/// <summary>
/// Represents a condition for ignoring dependencies.
/// </summary>
public sealed record Condition
{
  /// <summary>
  /// Gets or sets the dependency name pattern.
  /// </summary>
  public required string DependencyName { get; init; }

  /// <summary>
  /// Gets or sets the version requirement.
  /// </summary>
  public string? VersionRequirement { get; init; }

  /// <summary>
  /// Gets or sets the update types to ignore.
  /// </summary>
  public ImmutableArray<string>? UpdateTypes { get; init; }
}
