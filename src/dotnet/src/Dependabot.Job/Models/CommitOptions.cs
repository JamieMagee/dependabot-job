namespace Dependabot.Job;

/// <summary>
/// Represents commit message options for pull requests.
/// </summary>
public sealed record CommitOptions
{
  /// <summary>
  /// Gets or sets the commit message prefix.
  /// </summary>
  public string? Prefix { get; init; }

  /// <summary>
  /// Gets or sets whether to include a scope in commit messages.
  /// </summary>
  public bool? IncludeScope { get; init; }
}
