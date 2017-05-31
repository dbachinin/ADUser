Rails.application.routes.draw do
  get 'user_show_edit/new'

  get 'user_show_edit/show'

  get 'user_show_edit/create'

  get 'user_show_edit/update'

  get 'user_show_edit/delete'

  resources :servers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
