Rails.application.routes.draw do
  get 'about/about', to: 'about'
  root 'pages#index'
end
