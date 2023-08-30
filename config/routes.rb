Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/create'
  # get 'users/delete'
  devise_for :users

  as :user do
    resources :tasks do
      member do
        patch "update_status"
        get "change_status"
      end
    end
    resources :projects
    resources :users, except: [:create] do
      member do
        patch "update_user", to: "users#update_user"
      end
      collection do
        post "create_new", to: "users#create_new"
      end
    end
  end

  # get 'projects/index'
  # get 'projects/show'
  # get 'projects/edit'
  # get 'projects/update'
  # get 'projects/create'
  # get 'projects/delete'
  # get 'tasks/index'
  # get 'tasks/show'
  # get 'tasks/edit'
  # get 'tasks/update'
  # get 'tasks/create'
  # get 'tasks/delete'
  # get 'employees/index'
  # get 'employees/show'
  # get 'employees/edit'
  # get 'employees/update'
  # get 'employees/create'
  # get 'employees/delete'
  # get 'project_managers/show'
  # get 'project_managers/edit'
  # get 'project_managers/update'
  # get 'project_managers/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboards#index"
end
