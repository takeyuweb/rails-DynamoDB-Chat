DynamoChat::Application.routes.draw do
  resources :channels do
    resources :messages
  end
end
