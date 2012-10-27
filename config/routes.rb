Jqame::Engine.routes.draw do

  root to: 'questions#index'

  resources :questions do
    post :answer, :on => :member # creates new answer
  end

  resources :answers, except: [ :index, :new, :show, :create ]
  resources :comments, only: [ :destroy ]

  resources :votables, only: [] do
    post :upvote,   :on => :collection
    post :downvote, :on => :collection
    post :comment,  :on => :collection
  end

end
