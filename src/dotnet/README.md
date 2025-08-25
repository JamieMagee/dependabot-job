# Dependabot.Job

A modern .NET 8 library containing strongly-typed models for Dependabot job configurations. This library provides a clean, well-documented API for parsing and working with Dependabot job files in .NET applications.

## Features

- 🎯 **Modern .NET 8** targeting with latest C# language features
- 📦 **NuGet Package** ready for easy distribution
- 🔄 **JSON Serialization** support with System.Text.Json
- 🛡️ **Strong Typing** for all Dependabot job properties
- 📖 **Comprehensive Documentation** with XML comments
- 🧪 **Well Tested** with comprehensive unit tests
- ⚡ **AOT Compatible** for high-performance scenarios
- 🔧 **Extension Methods** for common operations

## Installation

```bash
dotnet add package Dependabot.Job
```

## Usage

### Basic Deserialization

```csharp
using System.Text.Json;
using Dependabot.Job;

var jobJson = File.ReadAllText("dependabot-job.json");
var job = JsonSerializer.Deserialize<Job>(jobJson, new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
});

Console.WriteLine($"Package Manager: {job.PackageManager}");
Console.WriteLine($"Source Provider: {job.Source.Provider}");
```

### Working with Directories

```csharp
using Dependabot.Job.Extensions;

// Get all directories to scan
var directories = job.GetAllDirectories();
foreach (var directory in directories)
{
    Console.WriteLine($"Scanning directory: {directory}");
}
```

### Checking Update Permissions

```csharp
var dependency = new Dependency
{
    Name = "Newtonsoft.Json",
    Version = "13.0.1"
};

if (job.IsUpdatePermitted(dependency))
{
    Console.WriteLine("Update is permitted for this dependency");
}
```

### Working with Dependency Groups

```csharp
var relevantGroups = job.GetRelevantDependencyGroups();
foreach (var group in relevantGroups)
{
    Console.WriteLine($"Group: {group.Name}, Applies to: {group.AppliesTo}");
}
```

## Model Structure

The library includes the following main models:

- `Job` - The main Dependabot job configuration
- `JobSource` - Source repository configuration
- `AllowedUpdate` - Update rules and restrictions
- `DependencyGroup` - Dependency grouping configuration
- `Dependency` - Individual dependency information
- `PullRequest` / `GroupPullRequest` - Pull request tracking
- `Advisory` - Security advisory information
- `Condition` - Ignore conditions

## JSON Converters

The library includes custom JSON converters for Dependabot-specific behavior:

- `NullAsBoolConverter` - Converts null JSON values to false for boolean properties
- `NullAsEmptyStringArrayConverter` - Converts null JSON values to empty arrays

## Extension Methods

Extension methods in `JobExtensions` provide utility functionality:

- `GetAllDirectories()` - Gets all directories to scan
- `GetRelevantDependencyGroups()` - Filters dependency groups by update type
- `GetAllExistingPullRequests()` - Combines individual and group pull requests
- `GetExistingPullRequestForDependencies()` - Finds matching existing PRs
- `IsDependencyIgnoredByNameOnly()` - Checks if dependency is ignored by name
- `IsUpdatePermitted()` - Determines if an update is allowed

## Configuration

The library supports standard Dependabot job configuration options including:

- Package manager settings
- Update strategies (security-only, version updates, etc.)
- Dependency filtering and grouping
- Pull request management
- Ignore conditions
- Commit message customization

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

This library is based on the Dependabot job model definitions from the [dependabot-core](https://github.com/dependabot/dependabot-core) project.
