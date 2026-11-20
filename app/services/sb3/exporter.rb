module Sb3
  # Builds a vanilla-compatible .sb3 from a project repository at a ref:
  # project.json plus every referenced asset, named by its MD5 the way the
  # Scratch editor expects (assets are stored by SHA-256 on our side).
  #
  # Restored 1.x/2.x blocks have no vanilla equivalent. The exporter must say
  # which ones a project uses instead of writing a file Scratch cannot load.
  class Exporter
    def initialize(project, ref: "HEAD")
      @project = project
      @ref = ref
    end

    # Returns the .sb3 bytes.
    def call
      raise NotImplementedError
    end
  end
end
