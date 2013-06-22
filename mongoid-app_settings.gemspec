# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/app_settings/version'

Gem::Specification.new do |gem|
  gem.name = "mongoid-app_settings"
  gem.version = Mongoid::AppSettings::VERSION
  gem.authors = ["Marten Veldthuis"]
  gem.email = "marten@veldthuis.com"
  gem.description = "Mongoid::AppSettings allows you to store settings in MongoDB, and access them easily"
  gem.summary = "Store settings for your application in MongoDB"
  gem.homepage = "http://github.com/marten/mongoid-app_settings"
  gem.licenses = ["MIT"]

  gem.files = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('mongoid', [">= 2.0"])
  gem.add_runtime_dependency('activesupport')

  gem.add_development_dependency('database_cleaner', ["~> 0.9"])
  gem.add_development_dependency('rspec', ["~> 2.11"])
  gem.add_development_dependency('appraisal')
  gem.add_development_dependency('pry')
end

