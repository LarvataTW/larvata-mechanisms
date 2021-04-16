Larvata::Mechanisms::Engine.routes.draw do
  devise_for :users, class_name: "Larvata::Mechanisms::User"

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
