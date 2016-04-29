require File.expand_path('../lib/deltek/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "deltek"
  gem.authors       = ["Andrea Rossi"]
  gem.email         = ["andrea.rossi@unep-wcmc.org"]
  gem.description   = gem.summary =  "A wrapper around the Deltek SOAP API"
  gem.homepage      = "https://github.com/unepwcmc/ruby-deltek"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.version       = Deltek::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'mocha'

  gem.add_dependency 'savon', '~> 2.11'
  gem.add_dependency 'httpclient', '~> 2.6'
  gem.add_dependency 'nokogiri', '~> 1.6'
  gem.add_dependency 'nori', '~> 2.6'
end
