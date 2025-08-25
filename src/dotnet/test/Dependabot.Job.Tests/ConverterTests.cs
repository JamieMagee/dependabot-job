using System.Collections.Immutable;
using System.Text.Json;
using System.Text.Json.Serialization;
using Dependabot.Job.Converters;
using FluentAssertions;
using Xunit;

namespace Dependabot.Job.Tests;

public class ConverterTests
{
  [Fact]
  public void NullAsBoolConverter_ShouldConvertNullToFalse()
  {
    // Arrange
    var converter = new NullAsBoolConverter();
    var reader = new Utf8JsonReader(JsonSerializer.SerializeToUtf8Bytes((bool?)null));
    reader.Read(); // advance to the null token

    // Act
    var result = converter.Read(ref reader, typeof(bool), new JsonSerializerOptions());

    // Assert
    result.Should().BeFalse();
  }

  [Fact]
  public void NullAsBoolConverter_ShouldPreserveBooleanValues()
  {
    // Arrange
    var converter = new NullAsBoolConverter();
    var reader = new Utf8JsonReader(JsonSerializer.SerializeToUtf8Bytes(true));
    reader.Read(); // advance to the boolean token

    // Act
    var result = converter.Read(ref reader, typeof(bool), new JsonSerializerOptions());

    // Assert
    result.Should().BeTrue();
  }

  [Fact]
  public void NullAsEmptyStringArrayConverter_ShouldConvertNullToEmptyArray()
  {
    // Arrange
    var converter = new NullAsEmptyStringArrayConverter();
    var reader = new Utf8JsonReader(JsonSerializer.SerializeToUtf8Bytes((string[]?)null));
    reader.Read(); // advance to the null token

    // Act
    var result = converter.Read(ref reader, typeof(ImmutableArray<string>), new JsonSerializerOptions());

    // Assert
    result.IsDefault.Should().BeFalse();
    result.Should().BeEmpty();
  }

  [Fact]
  public void NullAsEmptyStringArrayConverter_ShouldPreserveArrayValues()
  {
    // Arrange
    var converter = new NullAsEmptyStringArrayConverter();
    var testArray = new[] { "item1", "item2" };
    var reader = new Utf8JsonReader(JsonSerializer.SerializeToUtf8Bytes(testArray));
    reader.Read(); // advance to the array start token

    // Act
    var result = converter.Read(ref reader, typeof(ImmutableArray<string>), new JsonSerializerOptions());

    // Assert
    result.IsDefault.Should().BeFalse();
    result.Should().HaveCount(2);
    result.Should().Contain("item1");
    result.Should().Contain("item2");
  }

  [Fact]
  public void NullAsEmptyStringArrayConverter_Write_ShouldSerializeCorrectly()
  {
    // Arrange
    var converter = new NullAsEmptyStringArrayConverter();
    var array = ImmutableArray.Create("item1", "item2");
    using var stream = new MemoryStream();
    using var writer = new Utf8JsonWriter(stream);

    // Act
    converter.Write(writer, array, new JsonSerializerOptions());
    writer.Flush();

    // Assert
    var json = System.Text.Encoding.UTF8.GetString(stream.ToArray());
    json.Should().Contain("item1");
    json.Should().Contain("item2");
    json.Should().StartWith("[");
    json.Should().EndWith("]");
  }

  [Fact]
  public void Integration_Job_ShouldDeserializeWithConverters()
  {
    // Arrange
    var json = """
        {
            "package_manager": "nuget",
            "debug": null,
            "dependencies": null,
            "source": {
                "provider": "github"
            }
        }
        """;

    var options = new JsonSerializerOptions
    {
      PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
    };

    // Act
    var job = JsonSerializer.Deserialize<Job>(json, options);

    // Assert
    job.Should().NotBeNull();
    job!.PackageManager.Should().Be("nuget");
    job.Debug.Should().BeFalse(); // null should be converted to false
    job.Dependencies.Should().BeEmpty(); // null should be converted to empty array
    job.Source.Provider.Should().Be("github");
  }
}
