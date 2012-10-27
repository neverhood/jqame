Rails.application.routes.draw do

  root to: 'welcome#index'
  devise_for :employees, controllers: {registrations: "employees/registrations", passwords: "employees/passwords"}

  mount Jqame::Engine => "/jqame", :as => :jqame
end
