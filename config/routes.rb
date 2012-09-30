Jqame::Engine.routes.draw do

  root to: 'questions#index'
  resources :questions

end
