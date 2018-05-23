
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ec2/tracer/version"

Gem::Specification.new do |spec|
  spec.name          = "ec2-tracer"
  spec.version       = Ec2::Tracer::VERSION
  spec.authors       = ["cuongnm265"]
  spec.email         = ["cuongnm265@gmail.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.license       = "MIT"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "aws-sdk-ec2"
  spec.add_dependency "thor"
end
