Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  resources :posts do
    get 'my', to: 'posts#my_posts', on: :collection
  end
  resources :comments, only: [:create, :edit, :update, :destroy]
  root 'posts#index'
  resources :tags, only: [:show]
end
