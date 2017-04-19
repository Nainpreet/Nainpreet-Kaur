Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "callbacks"}
  root to: 'welcome#index'
  get'contact', to:'welcome#contact'
  get'map', to:'patients#map'
  post 'verifications' => 'verifications#create'
  put 'verifications' => 'verifications#verify'
  get'appointtment/new', to:'appointments#new1', as: 'new1_appointment'
  get'appointments/cancel/:id', to:'appointments#appointment_cancel', as: 'appointment_cancel'
  get'appointments/history', to:'appointments#appointment_history', as: 'appointment_history'
  post'appointment/create', to:'appointments#create_appointment', as: 'create_appointment'
  post'appointment/status', to:'appointments#appointment_status', as: 'appointment_status'
  get 'patients/update_doctors', as: 'update_doctors'
  get 'patients/show1', to:'patients#show1'
  resources :doctors
  resources :patients
  resources :departments
  resources :appointments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
