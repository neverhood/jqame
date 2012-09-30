Jqame::Engine.routes.draw do

  root to: 'questions#index'

  resources :questions do
    resources :answers, except: [ :index, :new ]
  end

  resources :comments, only: [ :create, :edit, :update, :destroy ]

end
