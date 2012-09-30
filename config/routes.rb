Jqame::Engine.routes.draw do

  root to: 'questions#index'

  resources :questions do
    resources :answers, except: [ :index, :new ]
  end

end
