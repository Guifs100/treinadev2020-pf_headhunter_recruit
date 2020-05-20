Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  authenticated :headhunters do
    root 'headhunter#index', as: :headhunters
  end
  # namespace :headhunters do
  #   root 'headhunter#index'
  # end

  resources :vacancies, only: %i[index show new create]
  
  root 'home#index'
end
