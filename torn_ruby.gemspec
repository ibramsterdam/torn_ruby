# frozen_string_literal: true

require_relative "lib/torn_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "torn_ruby"
  spec.version = TornRuby::VERSION
  spec.authors = ["Bram"]
  spec.email = ["bramjanssen@hey.com"]

  spec.summary = "A Ruby gem for interacting with the Torn City API, providing easy access to" \
                 "game data and functionality."
  spec.description = "A Ruby gem that provides a convenient wrapper around the Torn City API." \
                     "Ideal for developers looking to integrate Torn City data into Ruby applications."

  spec.homepage = "https://github.com/ibramsterdam/torn_ruby"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ibramsterdam/torn_ruby"
  spec.metadata["changelog_uri"] = "https://github.com/ibramsterdam/torn_ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "fiddle"
  spec.add_development_dependency "pry"
end
