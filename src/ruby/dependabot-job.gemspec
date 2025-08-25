# frozen_string_literal: true

require_relative 'lib/dependabot/job/version'

Gem::Specification.new do |spec|
  spec.name = 'dependabot-job'
  spec.version = Dependabot::Job::VERSION
  spec.authors = ['Jamie Magee']
  spec.email = ['jamie.magee@gmail.com']

  spec.summary = 'Ruby library for Dependabot job configurations'
  spec.description = 'A modern Ruby library containing strongly-typed models for ' \
                     'Dependabot job configurations with Sorbet type checking.'
  spec.homepage = 'https://github.com/dependabot/dependabot-job'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/dependabot/dependabot-job'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile sorbet/rbi/])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'sorbet-runtime', '~> 0.5'

  # Development dependencies
  spec.add_development_dependency 'minitest', '~> 5.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'rubocop-sorbet', '~> 0.8'
  spec.add_development_dependency 'sorbet', '~> 0.5'
  spec.add_development_dependency 'tapioca', '~> 0.11'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
