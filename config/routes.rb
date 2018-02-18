Annotot::Engine.routes.draw do
  resources :annotations, except: %i[new edit show], defaults: { format: :json }
end
