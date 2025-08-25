using System.Collections.Immutable;

namespace Dependabot.Job;

/// <summary>
/// Represents an existing pull request.
/// </summary>
public sealed record PullRequest
{
  /// <summary>
  /// Gets or sets the dependencies included in this pull request.
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
