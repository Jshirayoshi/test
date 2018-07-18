Rails.application.routes.draw do
  root to: 'syukeis#office'

  get 'syukeis/office'
  get 'syukeis' => 'syukeis#office'

  get 'syukeis/calc'
  post 'syukeis/calc'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
