Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'assignment/login' => 'assignment#create_login_form'
  post 'assignment/login' => 'assignment#authentication'
  get 'assignment/signup' => 'assignment#create_signup_form'
  post 'assignment/signup' => 'assignment#createnew'
  get 'assignment/transaction' => 'assignment#transaction'
  post 'assignment/transfer' => 'assignment#transfer'
  post 'assignment/repay' => 'assignment#repay'
end
