Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  post '/login', to: 'authentication#login'
  post '/signup', to: 'api/v1/users#create'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :edit, :destroy] 
      resources :doctors, only: [ :index, :show, :create, :edit ]
       resources :patients, only: [ :index, :show, :create, :edit ]
        resources :appointments, only: [ :index, :create, :edit, :destroy ]
        get '/patient_appointments/:id', to: 'appointments#patient_appointments'
        get '/doctor_appointment/:id', to: 'appointments#doctor_appointment'
        resources :medicines, only: [ :index, :create, :edit, :destroy ] do
          resources :medicines_eats, only: [ :create, :edit, ]
          get '/patient_medicines_eats/:id', to: 'medicines_eats#patient_medicines_eats'
        end
        get '/patient_medicines/:id', to: 'medicines#patient_medicines'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
