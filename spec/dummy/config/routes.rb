Rails.application.routes.draw do

  root to: 'welcome#index'
  devise_for :employees

  mount Jqame::Engine => "/jqame", :as => :jqame
end
