using System.Collections.Immutable;
using System.Text.Json;
using Dependabot.Job;
using Dependabot.Job.Enums;
using Dependabot.Job.Extensions;
using FluentAssertions;
using Xunit;

namespace Dependabot.Job.Tests;

public class JobTests
{
  [Fact]
  public void Job_ShouldDeserializeFromJson()
  {
    // Arrange
    var json = """
        {
            "package_manager": "nuget",
            "debug": null,
            "dependencies": null,
            "source": {
                "provider": "github",
                "repo": "test/repo",
                "directory": "/src"
            }
        }
        """;

    // Act
    var job = JsonSerializer.Deserialize<Job>(json, new JsonSerializerOptions
    {
      PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
    });

    // Assert
    job.Should().NotBeNull();
    job!.PackageManager.Should().Be("nuget");
    job.Debug.Should().BeFalse(); // null should be converted to false
    job.Dependencies.Should().BeEmpty(); // null should be converted to empty array
    job.Source.Provider.Should().Be("github");
    job.Source.Repo.Should().Be("test/repo");
    job.Source.Directory.Should().Be("/src");
  }

  [Fact]
  public void GetAllDirectories_ShouldReturnSourceDirectory()
  {
    // Arrange
    var job = new Job
    {
      Source = new JobSource
      {
        Provider = "github",
        Directory = "/src"
      }
    };

    // Act
    var directories = job.GetAllDirectories();

    // Assert
    directories.Should().ContainSingle().Which.Should().Be("/src");
  }

  [Fact]
  public void GetAllDirectories_ShouldReturnAllDirectories()
  {
    // Arrange
    var job = new Job
    {
      Source = new JobSource
      {
        Provider = "github",
        Directory = "/src",
        Directories = ["/test", "/docs"]
      }
    };

    // Act
    var directories = job.GetAllDirectories();

    // Assert
    directories.Should().HaveCount(3);
    directories.Should().Contain("/src");
    directories.Should().Contain("/test");
    directories.Should().Contain("/docs");
  }

  [Fact]
  public void GetAllDirectories_ShouldReturnRootWhenNoDirectories()
  {
    // Arrange
    var job = new Job
    {
      Source = new JobSource
      {
        Provider = "github"
      }
    };

    // Act
    var directories = job.GetAllDirectories();

    // Assert
    directories.Should().ContainSingle().Which.Should().Be("/");
  }

  [Fact]
  public void GetRelevantDependencyGroups_ShouldFilterBySecurityUpdates()
  {
    // Arrange
    var job = new Job
    {
      SecurityUpdatesOnly = true,
      DependencyGroups =
        [
            new DependencyGroup { Name = "security", AppliesTo = "security-updates" },
                new DependencyGroup { Name = "version", AppliesTo = "version-updates" }
        ],
      Source = new JobSource { Provider = "github" }
    };

    // Act
    var groups = job.GetRelevantDependencyGroups();

    // Assert
    groups.Should().ContainSingle();
    groups[0].Name.Should().Be("security");
  }

  [Fact]
  public void GetRelevantDependencyGroups_ShouldFilterByVersionUpdates()
  {
    // Arrange
    var job = new Job
    {
      SecurityUpdatesOnly = false,
      DependencyGroups =
        [
            new DependencyGroup { Name = "security", AppliesTo = "security-updates" },
                new DependencyGroup { Name = "version", AppliesTo = "version-updates" }
        ],
      Source = new JobSource { Provider = "github" }
    };

    // Act
    var groups = job.GetRelevantDependencyGroups();

    // Assert
    groups.Should().ContainSingle();
    groups[0].Name.Should().Be("version");
  }

  [Fact]
  public void IsDependencyIgnoredByNameOnly_ShouldReturnTrueForIgnoredDependency()
  {
    // Arrange
    var job = new Job
    {
      IgnoreConditions =
        [
            new Condition { DependencyName = "System.*" }
        ],
      Source = new JobSource { Provider = "github" }
    };

    // Act
    var isIgnored = job.IsDependencyIgnoredByNameOnly("System.Text.Json");

    // Assert
    isIgnored.Should().BeTrue();
  }

  [Fact]
  public void IsDependencyIgnoredByNameOnly_ShouldReturnFalseForNonIgnoredDependency()
  {
    // Arrange
    var job = new Job
    {
      IgnoreConditions =
        [
            new Condition { DependencyName = "System.*" }
        ],
      Source = new JobSource { Provider = "github" }
    };

    // Act
    var isIgnored = job.IsDependencyIgnoredByNameOnly("Newtonsoft.Json");

    // Assert
    isIgnored.Should().BeFalse();
  }
}
