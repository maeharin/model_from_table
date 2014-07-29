$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_from_table/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_from_table"
  s.version     = ModelFromTable::VERSION
  s.authors     = ["Hidenori Maehara"]
  s.email       = ["maeharin@gmail.com"]
  s.homepage    = "https://github.com/maeharin/model_from_table"
  s.summary     = "Rails generator for generating model from exsistent tables"
  s.description = "ModelFromTable is Rails generator for generating model from exsistent tables"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-rails"
end
