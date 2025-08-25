namespace Dependabot.Job;

/// <summary>
/// Represents cooldown settings for Dependabot operations.
/// </summary>
public sealed record Cooldown
{
  /// <summary>
  /// Gets or sets the cooldown duration in minutes.
  /// </summary>
  public int Duration { get; init; }

  /// <summary>
  /// Gets or sets the reason for the cooldown.
  /// </summary>
  public string? Reason { get; init; }
}
