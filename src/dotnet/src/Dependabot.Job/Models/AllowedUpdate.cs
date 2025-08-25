using System.Text.Json.Serialization;
using Dependabot.Job.Enums;

namespace Dependabot.Job;

/// <summary>
/// Represents an allowed update configuration for dependencies.
/// </summary>
public sealed record AllowedUpdate
{
  /// <summary>
  /// Gets or sets the type of update allowed.
  /// </summary>
  public UpdateType UpdateType { get; init; } = UpdateType.All;

  /// <summary>
  /// Gets or sets the dependency name pattern (supports wildcards).
  /// </summary>
  public string? DependencyName { get; init; }

  /// <summary>
  /// Gets or sets the dependency type.
  /// </summary>
  public string? DependencyType { get; init; }
}
