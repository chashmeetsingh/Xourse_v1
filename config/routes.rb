Rails.application.routes.draw do
  root to: "auth#login"
  get "/signup" => "auth#signup", :as => "signup"
  get "/login" => "auth#login" , :as => "login" 
  get "/course/show/:course_name" => "course#show"
  get "/index" => "auth#dashboard" , :as => "index"
  get "/api/create" => "api#create"
  get "/video/:id" => "video#show"
  get "/video/edit/:id" => "video#edit"
  get "/video/update/:id" => "video#update"
  get "/api/search/:keyword" => "api#search"
  match "/:controller(/:action(/:id))" , :via=>[:get,:post,:patch]
end
