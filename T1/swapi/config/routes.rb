Rails.application.routes.draw do

  scope "film", as: "film" do
    get "", to: "film#all"
    get "/specific", to: "film#specific"
  end

  scope "people", as: "people" do
    get "", to: "people#all"
    get "/specific", to: "people#specific"
  end

  scope "planet", as: "planet" do
    get "", to: "planet#all"
    get "/specific", to: "planet#specific"
  end

  scope "starship", as: "starship" do
    get "", to: "starship#all"
    get "/specific", to: "starship#specific"
  end
  
  root 'film#all'
end
