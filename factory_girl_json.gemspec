# -*- encoding: utf-8 -*-
require File.expand_path('../lib/factory_girl_json/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nikos Gereoudakis"]
  gem.email         = ["gereoudakis@gmail.com"]
  gem.description   = %q{Create json fixtures from your FactoryGirl factories}
  gem.summary       = %q{Create json fixtures from your FactoryGirl factories}
  gem.homepage      = "https://github.com/stream7/factory_girl_json"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "factory_girl_json"
  gem.require_paths = ["lib"]
  gem.version       = FactoryGirlJson::VERSION
  
  gem.add_dependency "factory_girl"
  gem.add_dependency "json"
  gem.add_dependency "database_cleaner"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "sqlite3"
end
