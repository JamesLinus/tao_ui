$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tao_ui/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tao_ui"
  s.version     = TaoUi::VERSION
  s.authors     = ["farthinker"]
  s.email       = ["farthinker@gmail.com"]
  s.homepage    = "https://github.com/mycolorway/tao_ui"
  s.summary     = "Tao UI"
  s.description = "UI library based on tao"
  s.license     = "MIT"

  s.required_ruby_version     = ">= 2.3.1"

  s.files = Dir["{lib,vendor,config}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "tao_on_rails", "~> 0.9.0"
  s.add_dependency "autoprefixer-rails", "~> 7.1.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "nokogiri", '~> 1.8.0'
  s.add_development_dependency "blade", "~> 0.7.0"
  s.add_development_dependency "blade-sauce_labs_plugin", "~> 0.7.0"
end
