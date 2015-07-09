# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "kitchen-provisioner-local_shell"
  spec.version       = "0.0.1"
  spec.authors       = ["Masashi Terui"]
  spec.email         = ["marcy9114@gmail.com"]
  spec.summary       = %q{A Test-Kitchen Provisioner that execute some command from localhost.}
  spec.description   = %q{A Test-Kitchen Provisioner that execute some command from localhost.}
  spec.homepage      = "https://github.com/marcy-terui/kitchen-provisioner-local_shell"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
