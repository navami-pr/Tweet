Rails.application.routes.draw do
	post 'auth/login', to: 'users#login'
	post 'forgot_password', to: 'passwords#forgot'
	post 'reset_password', to: 'passwords#reset'
	resources :tweets
end
