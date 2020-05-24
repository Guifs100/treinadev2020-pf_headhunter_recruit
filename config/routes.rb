Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  authenticated :headhunter do
    root 'headhunters_pages#index', as: :authenticated_headhunters
  end

  resources :vacancies, only: %i[index show new create]

  authenticated :candidate do
    root 'candidates_pages#index', as: :authenticated_candidates
  end

  resources :profiles, only: %i[show new create edit update]

  
  
  
  root 'home#index'
end
