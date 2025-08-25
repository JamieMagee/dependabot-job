using System.Collections.Immutable;

namespace Dependabot.Job;

/// <summary>
/// Represents an existing group pull request.
/// </summary>
public sealed record GroupPullRequest
{
  /// <summary>
  /// Gets or sets the name of the dependency group.
  /// </summary>
  public string? DependencyGroupName { get; init; }

  /// <summary>
  /// Gets or sets the dependencies included in this group pull request.
  /// </summary>
  public ImmutableArray<PullRequestDependency> Dependencies { get; init; } = [];

  /// <summary>
  /// Gets or sets the pull request number.
  /// </summary>
  public int? Number { get; init; }

  /// <summary>
  /// Gets or sets the pull request URL.
  /// </summary>
  public string? Url { get; init; }
}
