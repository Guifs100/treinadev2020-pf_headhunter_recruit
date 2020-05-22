Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  authenticated :headhunter do
    root 'headhunters_pages#index', as: :authenticated_headhunters
  end
  # scope module: 'headhunter' do
    resources :headhunters_pages, only: %i[index] do
      # get 'head', on: :collection
    end
  # end


  authenticated :candidate do
    root 'candidates_pages#index', as: :authenticated_candidates
  end

  # resources :candidates_pages, only: %i[index] do
    resources :profiles, only: %i[show new create ]
    # resources :profiles
  
  
  resources :vacancies, only: %i[index show new create]
  
  root 'home#index'
end
