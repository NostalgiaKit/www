module Lfs
  # Basic transfer adapter: download (GET) and upload (PUT) of single objects by oid.
  class ObjectsController < ActionController::API
    def show
      head :not_implemented
    end

    def update
      head :not_implemented
    end
  end
end
