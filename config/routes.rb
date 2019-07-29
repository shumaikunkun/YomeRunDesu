Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'example#top'
  #get 'example/top'
  get 'example/upload'
  post 'example/upload'
  post 'example/aaa'
  post 'example/bbb'
  post 'example/ccc'
  get 'example/ddd'
  post 'example/ddd'
  get 'example/test'



end
