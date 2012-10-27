Jqame::Engine.routes.draw do

  root to: 'questions#index'

  resources :questions do
    post :answer, :on => :member # creates new answer
  end
  resources :answers, except: [ :index, :new, :show, :create ]
  resources :comments, only: [ :create, :edit, :update, :destroy ]

end
