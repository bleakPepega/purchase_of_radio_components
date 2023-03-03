Rails.application.routes.draw do
  get '/about', to: 'about#about'
  get 'calculator', to: 'calculator#calculator'
  get 'contacts', to: 'contacts#contacts'
  get 'information', to: 'information#information'
  root 'pages#index'
  get '/pages/autocomplete_data', to: 'pages#autocomplete_data'
  get '/autocomplete_data/:group', to: 'products#autocomplete_data'
  post '/process_group_value', to: 'pages#process_group_value'
  get '/get_ruby_variable', to: 'pages#process_group_value'
  post 'process_input_value', to: 'pages#process_input_value'



end
