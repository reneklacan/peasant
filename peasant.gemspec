$:.push File.expand_path("../lib", __FILE__)

require 'peasant/version'

Gem::Specification.new do |s|
  s.name        = 'peasant'
  s.version     = Paesant::VERSION
  s.date        = '2014-07-01'
  s.summary     = ''
  s.description = ''
  s.authors     = ['Rene Klacan']
  s.email       = 'rene@klacan.sk'
  s.files       = Dir["{lib}/**/*", "LICENSE", "README.md"]
  s.executables = []
  s.homepage    = 'https://github.com/reneklacan/peasant'
  s.license     = 'Beerware'

  s.required_ruby_version = '~> 1.9'

  s.add_dependency 'eventmachine', '~> 1.0.3'
  s.add_dependency 'em-proxy', '~> 0.1.8'

  s.add_development_dependency 'rspec', '~> 3.0.0'
end
