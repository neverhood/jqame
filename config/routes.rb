Jqame::Engine.routes.draw do

  root to: 'questions#index'

  resources :questions do
    post :answer, :on => :member # creates new answer
  end

  resources :answers, except: [ :index, :new, :show, :create ] do
    post :accept, :on => :member # accepts answer
    post :unaccept, :on => :member # unaccepts answer
  end

  resources :comments, only: [ :destroy ]

  resources :votables, only: [] do
    post :upvote,   :on => :collection
    post :downvote, :on => :collection
    post :comment,  :on => :collection
    delete :destroy, :on => :collection
  end

end
