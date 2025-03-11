Rails.application.routes.draw do
  post '/operation', to: 'operations#create'
  post '/operation/confirm', to: 'operations#confirm_operation'
end
