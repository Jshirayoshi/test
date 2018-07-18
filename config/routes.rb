Rails.application.routes.draw do
  root 'syukeis#office'

  get 'syukeis/office'
  get 'syukeis/calc'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
