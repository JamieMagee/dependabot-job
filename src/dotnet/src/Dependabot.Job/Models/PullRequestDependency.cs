using NuGet.Versioning;

namespace Dependabot.Job;

/// <summary>
/// Represents a dependency in a pull request.
/// </summary>
public sealed record PullRequestDependency
{
  /// <summary>
  /// Gets or sets the name of the dependency.
  /// </summary>
  public required string DependencyName { get; init; }

  /// <summary>
  /// Gets or sets the version of the dependency.
  /// </summary>
  public required NuGetVersion DependencyVersion { get; init; }

  /// <summary>
  /// Gets or sets the directory where the dependency is located.
  /// </summary>
  public string? Directory { get; init; }
}
