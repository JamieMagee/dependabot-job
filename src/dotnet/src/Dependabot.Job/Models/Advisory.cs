namespace Dependabot.Job;

/// <summary>
/// Represents a security advisory.
/// </summary>
public sealed record Advisory
{
  /// <summary>
  /// Gets or sets the advisory identifier.
  /// </summary>
  public required string Id { get; init; }

  /// <summary>
  /// Gets or sets the advisory title.
  /// </summary>
  public string? Title { get; init; }

  /// <summary>
  /// Gets or sets the advisory description.
  /// </summary>
  public string? Description { get; init; }

  /// <summary>
  /// Gets or sets the severity level.
  /// </summary>
  public string? Severity { get; init; }

  /// <summary>
  /// Gets or sets the CVE identifier.
  /// </summary>
  public string? CveId { get; init; }

  /// <summary>
  /// Gets or sets the GHSA identifier.
  /// </summary>
  public string? GhsaId { get; init; }

  /// <summary>
  /// Gets or sets the affected package name.
  /// </summary>
  public string? PackageName { get; init; }

  /// <summary>
  /// Gets or sets the affected version range.
  /// </summary>
  public string? AffectedVersions { get; init; }

  /// <summary>
  /// Gets or sets the patched version range.
  /// </summary>
  public string? PatchedVersions { get; init; }
}
