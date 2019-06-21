$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "gitportal/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "gitportal"
  spec.version     = Gitportal::VERSION
  spec.authors     = ["John Salzarulo"]
  spec.email       = ["hello@withbetter.com"]
  spec.homepage    = "https://github.com/withbetterco/gitportal"
  spec.summary     = "Rails engine to create an interface to your git issues."
  spec.description = "Intended to provide a simple transparency of git issues inside of your project."
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

  spec.add_dependency "rails", "~> 5.0"
  spec.add_dependency "httparty"
  spec.add_dependency "graphql-client"
  spec.add_dependency "redcarpet"

end
