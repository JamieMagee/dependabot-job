using System.Text.Json.Serialization;

namespace Dependabot.Job.Enums;

/// <summary>
/// Represents the type of update allowed for dependencies.
/// </summary>
[JsonConverter(typeof(JsonStringEnumConverter<UpdateType>))]
public enum UpdateType
{
  /// <summary>
  /// Security updates only.
  /// </summary>
  Security,

  /// <summary>
  /// Version updates including patch, minor, and major versions.
  /// </summary>
  Version,

  /// <summary>
  /// All types of updates.
  /// </summary>
  All
}
