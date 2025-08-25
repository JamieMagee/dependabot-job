using System.Collections.Immutable;

namespace Dependabot.Job;

/// <summary>
/// Represents a dependency group configuration.
/// </summary>
public sealed record DependencyGroup
{
  /// <summary>
  /// Gets or sets the name of the dependency group.
  /// </summary>
  public required string Name { get; init; }

  /// <summary>
  /// Gets or sets what this group applies to (e.g., "version-updates", "security-updates").
  /// </summary>
  public string? AppliesTo { get; init; }

  /// <summary>
  /// Gets or sets the dependency type.
  /// </summary>
  public string? DependencyType { get; init; }

  /// <summary>
  /// Gets or sets the update types allowed for this group.
  /// </summary>
  public ImmutableArray<string> UpdateTypes { get; init; } = [];

  /// <summary>
  /// Gets or sets the patterns for dependencies to include.
  /// </summary>
  public ImmutableArray<string> Patterns { get; init; } = [];

  /// <summary>
  /// Gets or sets the patterns for dependencies to exclude.
  /// </summary>
  public ImmutableArray<string> ExcludePatterns { get; init; } = [];
}
