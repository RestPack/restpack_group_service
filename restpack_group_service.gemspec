# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restpack_group_service/version'

Gem::Specification.new do |spec|
  spec.name          = "restpack_group_service"
  spec.version       = RestPack::Group::Service::VERSION
  spec.authors       = ["Gavin Joyce"]
  spec.email         = ["gavinjoyce@gmail.com"]
  spec.description   = %q{Groups, Members and Invitations service}
  spec.summary       = %q{Groups, Members and Invitations}
  spec.homepage      = "https://github.com/RestPack"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "restpack_service", "~> 0"
  spec.add_dependency "restpack_service_messaging", "~> 0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bump"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "pry"
end
