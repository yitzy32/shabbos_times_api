Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get "/calendar" => "zmanims#index"
    get "/zmanims" => "zmanims#show"
  end
end
# hello test