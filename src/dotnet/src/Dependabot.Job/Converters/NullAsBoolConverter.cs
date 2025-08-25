using System.Collections.Immutable;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Dependabot.Job.Converters;

/// <summary>
/// JSON converter that treats null values as false for boolean properties.
/// </summary>
public sealed class NullAsBoolConverter : JsonConverter<bool>
{
  /// <inheritdoc />
  public override bool Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
  {
    return reader.TokenType == JsonTokenType.Null ? false : reader.GetBoolean();
  }

  /// <inheritdoc />
  public override void Write(Utf8JsonWriter writer, bool value, JsonSerializerOptions options)
  {
    writer.WriteBooleanValue(value);
  }
}
