lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "agilix/version"

Gem::Specification.new do |spec|
  spec.name          = "strongmind-agilix-buzz-client"
  spec.version       = Agilix::VERSION
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
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.18"
  spec.add_development_dependency "vcr", '~> 6.1'
  spec.add_development_dependency "webmock", '~> 3.18'
  spec.add_development_dependency "pry", '~> 0.14.2'
  # spec.add_development_dependency "guard"
  # spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "dotenv", '~> 2.8'
  spec.add_dependency "httparty", '~> 0.21.0'
  # spec.add_dependency "activesupport"
  spec.add_dependency "builder", '~> 3.2'
end
