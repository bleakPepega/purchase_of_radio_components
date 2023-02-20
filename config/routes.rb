Rails.application.routes.draw do
  get '/about', to: 'about#about'
  get 'calculator', to: 'calculator#calculator'
  get 'contacts', to: 'contacts#contacts'
  get 'information', to: 'information#information'
  root 'pages#index'
end
