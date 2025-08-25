using System.Collections.Immutable;
using System.Text.Json.Serialization;
using Dependabot.Job.Converters;
using Dependabot.Job.Enums;

namespace Dependabot.Job;

/// <summary>
/// Represents a Dependabot job configuration.
/// </summary>
public sealed record Job
{
  /// <summary>
  /// Gets or sets the package manager (e.g., "nuget").
  /// </summary>
  public string PackageManager { get; init; } = "nuget";

  /// <summary>
  /// Gets or sets the allowed updates configuration.
  /// </summary>
  public ImmutableArray<AllowedUpdate> AllowedUpdates { get; init; } = [new AllowedUpdate()];

  /// <summary>
  /// Gets or sets a value indicating whether debug mode is enabled.
  /// </summary>
  [JsonConverter(typeof(NullAsBoolConverter))]
  public bool Debug { get; init; } = false;

  /// <summary>
  /// Gets or sets the dependency groups.
  /// </summary>
  public ImmutableArray<DependencyGroup> DependencyGroups { get; init; } = [];

  /// <summary>
  /// Gets or sets the dependencies to update.
  /// </summary>
  [JsonConverter(typeof(NullAsEmptyStringArrayConverter))]
  public ImmutableArray<string> Dependencies { get; init; } = [];

  /// <summary>
  /// Gets or sets the dependency group to refresh.
  /// </summary>
  public string? DependencyGroupToRefresh { get; init; }

  /// <summary>
  /// Gets or sets the existing pull requests.
  /// </summary>
  public ImmutableArray<PullRequest> ExistingPullRequests { get; init; } = [];

  /// <summary>
  /// Gets or sets the existing group pull requests.
  /// </summary>
  public ImmutableArray<GroupPullRequest> ExistingGroupPullRequests { get; init; } = [];

  /// <summary>
  /// Gets or sets the experiments configuration.
  /// </summary>
  public Dictionary<string, object>? Experiments { get; init; }

  /// <summary>
  /// Gets or sets the ignore conditions.
  /// </summary>
  public ImmutableArray<Condition> IgnoreConditions { get; init; } = [];

  /// <summary>
  /// Gets or sets a value indicating whether only lockfile updates are allowed.
  /// </summary>
  public bool LockfileOnly { get; init; } = false;

  /// <summary>
  /// Gets or sets the requirements update strategy.
  /// </summary>
  public RequirementsUpdateStrategy? RequirementsUpdateStrategy { get; init; }

  /// <summary>
  /// Gets or sets the security advisories.
  /// </summary>
  public ImmutableArray<Advisory> SecurityAdvisories { get; init; } = [];

  /// <summary>
  /// Gets or sets a value indicating whether only security updates are allowed.
  /// </summary>
  public bool SecurityUpdatesOnly { get; init; } = false;

  /// <summary>
  /// Gets or sets the job source configuration.
  /// </summary>
  public required JobSource Source { get; init; }

  /// <summary>
  /// Gets or sets a value indicating whether subdependencies should be updated.
  /// </summary>
  public bool UpdateSubdependencies { get; init; } = false;

  /// <summary>
  /// Gets or sets a value indicating whether this is updating an existing pull request.
  /// </summary>
  public bool UpdatingAPullRequest { get; init; } = false;

  /// <summary>
  /// Gets or sets a value indicating whether dependencies should be vendored.
  /// </summary>
  public bool VendorDependencies { get; init; } = false;

  /// <summary>
  /// Gets or sets a value indicating whether external code should be rejected.
  /// </summary>
  public bool RejectExternalCode { get; init; } = false;

  /// <summary>
  /// Gets or sets a value indicating whether the repository is private.
  /// </summary>
  public bool RepoPrivate { get; init; } = false;

  /// <summary>
  /// Gets or sets the commit message options.
  /// </summary>
  public CommitOptions? CommitMessageOptions { get; init; }

  /// <summary>
  /// Gets or sets the credentials metadata.
  /// </summary>
  public ImmutableArray<Dictionary<string, object>>? CredentialsMetadata { get; init; }

  /// <summary>
  /// Gets or sets the maximum updater run time in seconds.
  /// </summary>
  public int MaxUpdaterRunTime { get; init; } = 0;

  /// <summary>
  /// Gets or sets the cooldown configuration.
  /// </summary>
  public Cooldown? Cooldown { get; init; }
}
