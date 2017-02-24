Rails.application.routes.draw do
  get '/' => 'users#index'

  post 'users/create' => 'users#create'

  post 'users/login' => 'users#login'

  get 'bright_ideas' => 'users#main'

  post 'users/logout' => 'users#logout'

  post 'ideas/:id' => 'users#idea_create'

  post 'ideas/:id/delete' => 'users#delete'

  post 'ideas/:id/unlike' => 'users#unlike'

  post 'ideas/:id/like' => 'users#like'

  get 'users/:id' => 'users#show'

  get 'bright_ideas/:id' => 'users#idea'

  get 'users/delete'

  get 'users/idea'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
