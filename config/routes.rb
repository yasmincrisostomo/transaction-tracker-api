Rails.application.routes.draw do
  resources :transactions do
    collection do
      post :upload_transactions_csv
    end
  end

  resources :products do
    member do
      get :total_spent
    end
  end

  get 'transactions/transactions_within_date_range_for_product/:product_id', to: 'transactions#transactions_within_date_range_for_product', as: 'transactions_within_date_range'
end