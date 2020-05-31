Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  authenticated :headhunter do
    root 'headhunters_home#index', as: :headhunters_home
  end

  resources :vacancies, only: %i[ show new create update] do
    get 'search', on: :collection
    get 'headhunter_vacancies', on: :collection
    get 'answer_proposals', on: :collection
    post '/close/vacancy/:id', to: 'vacancies#close_vacancy', as: 'close_vacancy', on: :collection
    resources :apply_vacancies, only: %i[ index show new create ] do
      resources :reject_apply_vacancies, only: %i[ new create]
      resources :proposals, only: %i[ show new create edit update]
    end
  end

  resources :levels, only: %i[new create]
  
  
  authenticated :candidate do
    root 'candidates_home#index', as: :candidates_home
  end
  
  resources :profiles, only: %i[show new create edit update] do
    get 'all_apply_jobs', on: :collection
    get 'all_reject_applies', on: :collection
    get 'all_proposals', on: :collection
    resources :comments, only: %i[new create]
    resources :star_profiles, only: %i[create destroy]
  end

  root 'home#index'
end
