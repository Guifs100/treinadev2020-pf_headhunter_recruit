Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  authenticated :headhunter do
    root 'headhunters_home#index', as: :headhunters_home
  end

  resources :vacancies, only: %i[ index show new create] do
    get 'search', on: :collection
    resources :apply_vacancies, only: %i[ index show new create ]
  end

  resources :levels, only: %i[new create]


  authenticated :candidate do
    root 'candidates_home#index', as: :candidates_home
  end

  resources :profiles, only: %i[show new create edit update] do
    get 'all_apply_jobs', on: :collection
  end

  root 'home#index'
end
