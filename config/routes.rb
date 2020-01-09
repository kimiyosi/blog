Rails.application.routes.draw do
  match 'ajax/get_sub_categories/', to: 'ajax#get_sub_categories', as: "ajax_get_sub_categories", via: :all
  match 'image/show_image/:code', to: 'image#show_image', as: "show_image", via: :all

  resource :admin do
    resources :sub_categories
    resources :categories
    resources :reports
    resources :images
  end

  get '', to: "main#index", as: "main_index"
  get ':category_name', to: "main#category", as: "main_category"
  get ':category_name/:sub_category_name', to: "main#sub_category", as: "main_sub_category"
  get ':category_name/:sub_category_name/:code', to: "main#report", as: "main_report"

  match '*path(.:format)', to: 'main#page_not_found', via: :all
end
