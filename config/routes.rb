Rails.application.routes.draw do
  devise_for :headhunters
  
  authenticated :headhunters do
    root 'headhunter#index', as: :headhunters
  end
  # namespace :headhunters do
  #   root 'headhunter#index'
  # end

  resources :vacancies, only: %i[index new create]
  
  root 'home#index'
end
