module Annotot
  ##
  # Install generator
  class Install < Rails::Generators::Base
    def add_routes
      route "mount Annotot::Engine => '/'"
    end
  end
end
