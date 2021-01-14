Rails.application.routes.draw do

  get 'survey/new'

  get 'survey/new'
  get 'survey/saved'
  get 'survey/error'
  post 'survey/submit'

  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
  mount Blacklight::Engine => '/'
  
    concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  get '/cite' => 'hyrax/pages#show', key: 'cite'
  get '/schemes-of-work' => 'hyrax/pages#show', key: 'schemes_of_work'
  get '/all-collections' => 'hyrax/pages#show', key: 'all_collections'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
