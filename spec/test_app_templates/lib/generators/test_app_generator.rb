require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root './spec/test_app_templates'

  # if you need to generate any additional configuration
  # into the test app, this generator will be run immediately
  # after setting up the application

  def install_engine
    generate 'annotot:install'
  end

  def run_annotot_migrations
    rake 'annotot:install:migrations'
    rake 'db:migrate'
  end
end
