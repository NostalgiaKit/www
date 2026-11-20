# The one page that loads heavy JavaScript. It frames the prebuilt editor for
# the project's language (see editors/README.md) and nothing else.
class EditorsController < ApplicationController
  include ProjectScoped
  layout "editor"

  def show
    # TODO: a load/save bridge (postMessage) between the editor frame and
    # Git::ProjectRepository#read / #commit!.
  end
end
