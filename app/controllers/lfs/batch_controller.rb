module Lfs
  # Git LFS batch API: https://github.com/git-lfs/git-lfs/blob/main/docs/api/batch.md
  # Answers which objects the client should upload or download, pointing it at
  # Lfs::ObjectsController (backed by LfsObject and Active Storage).
  class BatchController < ActionController::API
    def create
      # TODO: authenticate, then respond with application/vnd.git-lfs+json
      head :not_implemented
    end
  end
end
