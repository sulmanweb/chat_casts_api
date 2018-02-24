Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  # Error handling
  match '/404', to: 'error/errors#not_found', via: :all
  match '/500', to: 'error/errors#internal_server_error', via: :all
end
