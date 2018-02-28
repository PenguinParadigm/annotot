module Annotot
  ##
  # Install generator
  class Install < Rails::Generators::Base
    def add_routes
      route "mount Annotot::Engine => '/'"
    end

    def run_annotot_migrations
      rake 'annotot:install:migrations'
      rake 'db:migrate'
    end
  end
end
