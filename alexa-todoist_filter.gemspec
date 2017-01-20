# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alexa/todoist_filter/version'

Gem::Specification.new do |spec|
  spec.name          = "alexa-todoist_filter"
  spec.version       = Alexa::TodoistFilter::VERSION
  spec.authors       = ["Clark Burns"]
  spec.email         = ["rclarkburns@icloud.com"]

  spec.summary       = %q{A command line tool for moving Alexa todos in Todoist into a user specified project.}
  spec.description   = %q{A command line tool for moving Alexa todos in Todoist into a user specified project.}
  spec.homepage      = "https://github.com/rclarkburns/alexa-todoist_filter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "thor", "~> 0.19.4"
  spec.add_runtime_dependency "faraday", "~> 0.11.0"
end
