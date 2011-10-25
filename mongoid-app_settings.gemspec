# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongoid-app_settings"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marten Veldthuis"]
  s.date = "2011-10-25"
  s.description = "Mongoid::AppSettings allows you to store settings in MongoDB, and access them easily"
  s.email = "marten@veldthuis.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "lib/mongoid-app_settings.rb",
    "spec/mongoid-app_settings_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/marten/mongoid-app_settings"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Store settings for your application in MongoDB"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<bson_ext>, ["= 1.4.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<bson_ext>, ["= 1.4.1"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<bson_ext>, ["= 1.4.1"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

