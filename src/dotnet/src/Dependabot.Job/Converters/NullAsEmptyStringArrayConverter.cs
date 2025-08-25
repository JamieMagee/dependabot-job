using System.Collections.Immutable;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Dependabot.Job.Converters;

/// <summary>
/// JSON converter that treats null values as empty string arrays for ImmutableArray&lt;string&gt; properties.
/// </summary>
public sealed class NullAsEmptyStringArrayConverter : JsonConverter<ImmutableArray<string>>
{
  /// <inheritdoc />
  public override ImmutableArray<string> Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
  {
    if (reader.TokenType == JsonTokenType.Null)
    {
      return [];
    }

    var builder = ImmutableArray.CreateBuilder<string>();
    if (reader.TokenType == JsonTokenType.StartArray)
    {
      reader.Read();
      while (reader.TokenType != JsonTokenType.EndArray)
      {
        if (reader.TokenType == JsonTokenType.String)
        {
          var value = reader.GetString();
          if (value is not null)
          {
            builder.Add(value);
          }
        }
        reader.Read();
      }
    }

    return builder.ToImmutable();
  }

  /// <inheritdoc />
  public override void Write(Utf8JsonWriter writer, ImmutableArray<string> value, JsonSerializerOptions options)
  {
    writer.WriteStartArray();
    foreach (var item in value)
    {
      writer.WriteStringValue(item);
    }
    writer.WriteEndArray();
  }
}
