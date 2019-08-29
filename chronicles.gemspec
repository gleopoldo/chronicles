
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chronicles/version"

Gem::Specification.new do |spec|
  spec.name          = "chronicles"
  spec.version       = Chronicles::VERSION
  spec.authors       = ["Gabriel Ferreira"]
  spec.email         = ["gabrielleopferreira@gmail.com"]

  spec.summary       = %q{This is a fun, chronicles generator game}
  spec.description   = %q{Enjoy epic chronicles generated randomly. E-mail your friends with them!}
  #spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "state_machines"
  spec.add_dependency "concurrent-ruby"
  spec.add_dependency "concurrent-ruby-edge"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
