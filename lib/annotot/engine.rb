module Annotot
  class Engine < ::Rails::Engine
    isolate_namespace Annotot

    config.before_configuration do
      # see https://github.com/fxn/zeitwerk#for_gem
      # Blacklight puts a generator into LOCAL APP lib/generators, so tell
      # zeitwerk to ignore the whole directory? If we're using a recent
      # enough version of Rails to have zeitwerk config
      #
      # See: https://github.com/cbeer/engine_cart/issues/117
      if Rails.try(:autoloaders).try(:main).respond_to?(:ignore)
        Rails.autoloaders.main.ignore(Rails.root.join('lib/generators'))
      end
    end
  end
end
