using System.Text.Json.Serialization;

namespace Dependabot.Job.Enums;

/// <summary>
/// Represents the strategy for updating dependency requirements.
/// </summary>
[JsonConverter(typeof(JsonStringEnumConverter<RequirementsUpdateStrategy>))]
public enum RequirementsUpdateStrategy
{
  /// <summary>
  /// Automatically determine the best strategy.
  /// </summary>
  Auto,

  /// <summary>
  /// Widen version ranges when possible.
  /// </summary>
  Widen,

  /// <summary>
  /// Increase version requirements to minimum supported.
  /// </summary>
  Increase,

  /// <summary>
  /// Increase version requirements only if required.
  /// </summary>
  IncreaseIfNecessary,

  /// <summary>
  /// Lock to exact version.
  /// </summary>
  LockfileOnly
}
