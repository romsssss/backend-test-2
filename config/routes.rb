Rails.application.routes.draw do

  root 'calls#index'

  resources :calls, only: [:index, :show, :destroy]

  # resources :plivo_calls, only: [] do
  #   collection do
  #     post 'inbound'
  #     post 'hangup'
  #     post 'fallback'
  #     post 'voicemail'
  #   end
  # end

end
