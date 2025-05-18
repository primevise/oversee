require_relative "lib/oversee/version"

Gem::Specification.new do |spec|
  spec.name        = "oversee"
  spec.version     = Oversee::VERSION
  spec.license     = "MIT"
  spec.authors     = ["Elvinas Predkelis", "Primevise"]
  spec.email       = ["info@primevise.com"]
  spec.homepage    = "https://rubygems.org/gems/oversee"
  spec.summary     = "Plug & play CMS for Rails applications"
  spec.description = "Plug & play CMS for Rails applications"
 	spec.required_ruby_version = ">= 3.3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/primevise/oversee"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "LICENCE", "Rakefile", "README.md"]
  end

  spec.add_dependency "activerecord", ">= 7.0.0"
  spec.add_dependency "activesupport", ">= 7.0.0"
  spec.add_dependency "activestorage", ">= 7.0.0"
  spec.add_dependency "importmap-rails", "~> 2.0"
  spec.add_dependency "pagy", ">= 7.0.0"
  spec.add_dependency "phlex-rails", ">= 2.2.0"
  spec.add_dependency "phlex-icons-iconoir", ">= 0.1.0"
  spec.add_dependency "turbo-rails", ">= 2.0.0"
  spec.add_dependency "zeitwerk", ">= 2.6.12"
  spec.add_dependency "tailwind_merge"
end
