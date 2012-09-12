Rails.application.routes.draw do

  devise_for :employees

  mount Jqame::Engine => "/jqame"
end
