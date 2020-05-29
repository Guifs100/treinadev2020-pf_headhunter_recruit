Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  authenticated :headhunter do
    root 'headhunters_home#index', as: :headhunters_home
  end

  resources :vacancies, only: %i[ show new create] do
    get 'search', on: :collection
    get 'headhunter_vacancies', on: :collection
    resources :apply_vacancies, only: %i[ index show new create ] do
      resources :reject_apply_vacancies, only: %i[ new create]
    end
  end

  resources :levels, only: %i[new create]
  
  
  authenticated :candidate do
    root 'candidates_home#index', as: :candidates_home
  end
  
  resources :profiles, only: %i[show new create edit update] do
    get 'all_apply_jobs', on: :collection
    resources :comments, only: %i[new create]
    resources :star_profiles, only: %i[create destroy]
  end

  root 'home#index'
end
