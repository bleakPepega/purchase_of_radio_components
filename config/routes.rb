Rails.application.routes.draw do
  root 'components#index'

  get '/about', to: 'about#index'
  get 'calculator', to: 'components#index'
  get 'contacts', to: 'contacts#index'
  get 'information', to: 'information#index'

  get '/pages/autocomplete_data', to: 'pages#autocomplete_data'
  get '/autocomplete_data/:group', to: 'products#autocomplete_data'
  post '/process_group_value', to: 'pages#process_group_value'
  get '/get_ruby_variable', to: 'pages#process_group_value'
  post 'process_input_value', to: 'pages#process_input_value'

  get '/component/search', to: 'components#autocomplete_name'
  post '/component/calculate', to: 'components#calculate'
end
