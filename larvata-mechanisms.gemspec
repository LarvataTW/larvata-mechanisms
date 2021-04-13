$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "larvata/mechanisms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "larvata-mechanisms"
  spec.version     = Larvata::Mechanisms::VERSION
  spec.authors     = ["JackTsai"]
  spec.email       = ["jacktsai@larvata.tw"]
  spec.homepage    = "https://larvata.tw"
  spec.summary     = "Larvata::Mechanisms for Rails application."
  spec.description = "Larvata::Mechanisms provides helpers and concerns for Rails application."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.5"
  spec.add_dependency "ransack", "~> 2.4.2"
  spec.add_dependency "pagy", "~> 3.12.0"

  spec.add_development_dependency "mysql2"
end
