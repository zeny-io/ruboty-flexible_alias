# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/flexible_alias/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruboty-flexible_alias'
  spec.version       = Ruboty::FlexibleAlias::VERSION
  spec.authors       = ['Sho Kusano']
  spec.email         = ['sho-kusano@zeny.io']

  spec.summary       = 'Provides flexible alias to ruboty'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/zeny-io/ruboty-flexible_alias'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'ruboty-echo'
  spec.add_dependency 'ruboty'
end
