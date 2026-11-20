Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # ActivityPub (phase 1): actors, inboxes, outboxes and WebFinger.
  mount Federails::Engine => "/"

  root "home#index"
  get "explore" => "projects#index", as: :explore

  resources :forum_topics, path: "forums", only: %i[index show]

  # Git over HTTP for `git clone` and `git lfs pull`. Kept apart from the HTML
  # routes so the ".git" suffix never collides with a project page.
  scope "/~:user_username/:project_slug.git", format: false, as: :git do
    # TODO: smart HTTP (info/refs, git-upload-pack) on top of Rugged.
    post "info/lfs/objects/batch" => "lfs/batch#create", as: :lfs_batch
    get  "info/lfs/objects/:oid" => "lfs/objects#show", as: :lfs_object
    put  "info/lfs/objects/:oid" => "lfs/objects#update"
  end

  # Launchpad-style URLs: /~username/project/+bugs/12
  scope "/~:user_username", as: :user do
    get "/" => "users#show"

    resources :projects, path: "", param: :slug, only: %i[show] do
      get "editor" => "editors#show"
      get "export.sb3" => "exports#show", format: false, as: :export
      get "commits" => "commits#index"
      get "commits/:sha" => "commits#show", as: :commit
      get "tree(/*path)" => "trees#show", as: :tree, format: false

      resources :pull_requests, path: "+merges", only: %i[index show]
      resources :issues, path: "+bugs", param: :number, only: %i[index show]
      resources :blueprints, path: "+specs", param: :name, only: %i[index show]
    end
  end
end
