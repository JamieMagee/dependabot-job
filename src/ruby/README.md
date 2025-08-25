# Dependabot::Job

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dependabot/job`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

# Dependabot::Job

A modern Ruby library containing strongly-typed models for Dependabot job configurations with Sorbet type checking. This library provides a clean, well-documented API for parsing and working with Dependabot job files in Ruby applications.

## Features

- 🎯 **Modern Ruby 3.1+** with latest language features
- 📦 **Gem Package** ready for easy distribution
- 🔄 **JSON Serialization** support with built-in JSON library
- 🛡️ **Strong Typing** with Sorbet for all Dependabot job properties
- 📖 **Comprehensive Documentation** with inline comments
- 🧪 **Well Tested** with comprehensive unit tests using Minitest
- ⚡ **High Performance** with efficient data structures
- 🔧 **Extension Methods** for common operations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dependabot-job'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dependabot-job

## Usage

### Basic Deserialization

```ruby
require 'dependabot/job'

job_json = File.read('dependabot-job.json')
job = Dependabot::Job.from_json(job_json)

puts "Package Manager: #{job.package_manager}"
puts "Source Provider: #{job.source.provider}"
```

### Working with Directories

```ruby
require 'dependabot/job/extensions/job_extensions'

# Get all directories to scan
directories = Dependabot::Job::Extensions::JobExtensions.all_directories(job)
directories.each do |directory|
  puts "Scanning directory: #{directory}"
end
```

### Checking Update Permissions

```ruby
dependency = Dependabot::Job::Models::Dependency.new(
  name: 'rails',
  version: '7.0.0'
)

if Dependabot::Job::Extensions::JobExtensions.update_permitted?(job, dependency)
  puts "Update is permitted for this dependency"
end
```

### Working with Dependency Groups

```ruby
relevant_groups = Dependabot::Job::Extensions::JobExtensions.relevant_dependency_groups(job)
relevant_groups.each do |group|
  puts "Group: #{group.name}, Applies to: #{group.applies_to}"
end
```

## Model Structure

The library includes the following main models:

- `Dependabot::Job::Models::Job` - The main Dependabot job configuration
- `Dependabot::Job::Models::JobSource` - Source repository configuration
- `Dependabot::Job::Models::AllowedUpdate` - Update rules and restrictions
- `Dependabot::Job::Models::DependencyGroup` - Dependency grouping configuration
- `Dependabot::Job::Models::Dependency` - Individual dependency information
- `Dependabot::Job::Models::PullRequest` / `GroupPullRequest` - Pull request tracking
- `Dependabot::Job::Models::Advisory` - Security advisory information
- `Dependabot::Job::Models::Condition` - Ignore conditions

## Serializers

The library includes custom serializers for Dependabot-specific behavior:

- `NullAsBoolSerializer` - Converts null JSON values to false for boolean properties
- `NullAsEmptyArraySerializer` - Converts null JSON values to empty arrays

## Extension Methods

Extension methods in `JobExtensions` provide utility functionality:

- `all_directories(job)` - Gets all directories to scan
- `relevant_dependency_groups(job)` - Filters dependency groups by update type
- `all_existing_pull_requests(job)` - Combines individual and group pull requests
- `existing_pull_request_for_dependencies(job, deps, consider_versions)` - Finds matching existing PRs
- `dependency_ignored_by_name_only?(job, name)` - Checks if dependency is ignored by name
- `update_permitted?(job, dependency)` - Determines if an update is allowed

## Configuration

The library supports standard Dependabot job configuration options including:

- Package manager settings
- Update strategies (security-only, version updates, etc.)
- Dependency filtering and grouping
- Pull request management
- Ignore conditions
- Commit message customization

## Type Safety with Sorbet

This library uses Sorbet for static type checking. All models include proper type annotations:

```ruby
# typed: strict
sig { params(job: Models::Job).returns(T::Array[String]) }
def self.all_directories(job)
  # Implementation
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dependabot/dependabot-job.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgments

This library is based on the Dependabot job model definitions from the [dependabot-core](https://github.com/dependabot/dependabot-core) project and is the Ruby equivalent of the .NET Dependabot.Job library.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dependabot-job.
