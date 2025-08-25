using System.Collections.Immutable;
using System.IO.Enumeration;
using Microsoft.Extensions.FileSystemGlobbing;
using NuGet.Versioning;

namespace Dependabot.Job.Extensions;

/// <summary>
/// Extension methods for the <see cref="Job"/> class.
/// </summary>
public static class JobExtensions
{
  /// <summary>
  /// Gets all directories to scan for dependencies.
  /// </summary>
  /// <param name="job">The job instance.</param>
  /// <returns>An immutable array of directory paths.</returns>
  public static ImmutableArray<string> GetAllDirectories(this Job job)
  {
    ArgumentNullException.ThrowIfNull(job);

    var builder = ImmutableArray.CreateBuilder<string>();

    if (job.Source.Directory is not null)
    {
      builder.Add(job.Source.Directory);
    }

    builder.AddRange(job.Source.Directories ?? []);

    if (builder.Count == 0)
    {
      builder.Add("/");
    }

    return builder.ToImmutable();
  }

  /// <summary>
  /// Gets the relevant dependency groups based on the job configuration.
  /// </summary>
  /// <param name="job">The job instance.</param>
  /// <returns>An immutable array of relevant dependency groups.</returns>
  public static ImmutableArray<DependencyGroup> GetRelevantDependencyGroups(this Job job)
  {
    ArgumentNullException.ThrowIfNull(job);

    var appliesToKey = job.SecurityUpdatesOnly ? "security-updates" : "version-updates";
    var groups = job.DependencyGroups
        .Where(g => g.AppliesTo == appliesToKey)
        .ToImmutableArray();

    return groups;
  }

  /// <summary>
  /// Gets all existing pull requests, including both individual and group pull requests.
  /// </summary>
  /// <param name="job">The job instance.</param>
  /// <returns>A collection of tuples containing the dependency group name (if any) and dependencies.</returns>
  public static ImmutableArray<(string? DependencyGroupName, ImmutableArray<PullRequestDependency> Dependencies)> GetAllExistingPullRequests(this Job job)
  {
    ArgumentNullException.ThrowIfNull(job);

    var existingPullRequests = job.ExistingGroupPullRequests
        .Select(pr => (pr.DependencyGroupName, pr.Dependencies))
        .Concat(job.ExistingPullRequests.Select(pr => ((string?)null, pr.Dependencies)))
        .ToImmutableArray();

    return existingPullRequests;
  }

  /// <summary>
  /// Gets an existing pull request that matches the specified dependencies.
  /// </summary>
  /// <param name="job">The job instance.</param>
  /// <param name="dependencies">The dependencies to match.</param>
  /// <param name="considerVersions">Whether to consider versions when matching.</param>
  /// <returns>A tuple containing the dependency group name and dependencies if found; otherwise, null.</returns>
  public static (string? DependencyGroupName, ImmutableArray<PullRequestDependency> Dependencies)? GetExistingPullRequestForDependencies(
      this Job job,
      IEnumerable<Dependency> dependencies,
      bool considerVersions)
  {
    ArgumentNullException.ThrowIfNull(job);
    ArgumentNullException.ThrowIfNull(dependencies);

    if (dependencies.Any(d => d.Version is null))
    {
      return null;
    }

    string CreateIdentifier(string dependencyName, string dependencyVersion)
    {
      return $"{dependencyName}/{(considerVersions ? dependencyVersion : null)}";
    }

    var desiredDependencySet = dependencies
        .Select(d => CreateIdentifier(d.Name, d.Version!))
        .ToHashSet(StringComparer.OrdinalIgnoreCase);

    var existingPullRequests = job.GetAllExistingPullRequests();
    var existingPullRequest = existingPullRequests
        .FirstOrDefault(pr =>
        {
          var prDependencySet = pr.Dependencies
                  .Select(d => CreateIdentifier(d.DependencyName, d.DependencyVersion.ToString()))
                  .ToHashSet(StringComparer.OrdinalIgnoreCase);

          return prDependencySet.SetEquals(desiredDependencySet);
        });

    return existingPullRequest == default ? null : existingPullRequest;
  }

  /// <summary>
  /// Determines whether a dependency is ignored by name only (without version restrictions).
  /// </summary>
  /// <param name="job">The job instance.</param>
  /// <param name="dependencyName">The name of the dependency to check.</param>
  /// <returns>True if the dependency is ignored by name only; otherwise, false.</returns>
  public static bool IsDependencyIgnoredByNameOnly(this Job job, string dependencyName)
  {
    ArgumentNullException.ThrowIfNull(job);
    ArgumentException.ThrowIfNullOrWhiteSpace(dependencyName);

    var packageNamesToIgnore = job.IgnoreConditions
        .Where(c => (c.UpdateTypes ?? []).Length == 0 && c.VersionRequirement is null)
        .Select(c => c.DependencyName)
        .ToArray();

    var isIgnored = packageNamesToIgnore
        .Any(p => FileSystemName.MatchesSimpleExpression(p, dependencyName));

    return isIgnored;
  }
}
