Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :edit, :destroy] 
      resources :doctors, only: [ :index, :show, :create, :edit ]
       resources :patients, only: [ :index, :show, :create, :edit ]
        resources :appointments, only: [ :index, :create, :edit, :destroy ]
        get '/patient_appointments/:id', to: 'appointments#patient_appointments'
        get '/doctor_appointment/:id', to: 'appointments#doctor_appointment'
        resources :medicines, only: [ :index, :create, :edit, :destroy ]
        get '/patient_medicines/:id', to: 'medicines#patient_medicines'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
