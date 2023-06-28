lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "agilix/version"

Gem::Specification.new do |spec|
  spec.name          = "agilix-buzz-client"
  spec.version       = Agilix-Buzz-Client::VERSION
  spec.authors       = ["Strongmind"]
  spec.email         = ["qwertytalk@strongmind.com"]

  spec.summary       = %q{Agilix Buzz API wrapper}
  spec.description   = %q{Fully implements Agilix Buzz API in Ruby}
  spec.homepage      = "https://github.com/Strongmind/agilix-buzz-client"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Strongmind/agilix-buzz-client"
  spec.metadata["changelog_uri"] = "https://github.com/Strongmind/agilix-buzz-client"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "faraday", '~> 1.1'
  spec.add_dependency "faraday_middleware", '~> 1.2'
  spec.add_dependency "simple_oauth", '~> 0.3.1'
  spec.add_dependency "rails", '~> 7.0'
  spec.add_dependency "railties", "~> 7.0"
end
