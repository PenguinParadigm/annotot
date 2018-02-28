Annotot::Engine.routes.draw do
  resources :annotations, except: %i[new edit show], defaults: { format: :json } do
    collection do
      get 'lists'
    end
  end
end
