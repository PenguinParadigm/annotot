$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'annotot/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'annotot'
  s.version     = Annotot::VERSION
  s.authors     = ['Jack Reed']
  s.email       = ['phillipjreed@gmail.com']
  s.homepage    = 'https://github.com/mejackreed/annotot'
  s.summary     = 'Annotot. Open annotations in Rails.'
  s.description = 'Annotot. Open annotations in Rails.'
  s.license     = 'Apache-2.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 7.0', '< 9'

  s.add_development_dependency 'engine_cart'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-rails'
end
