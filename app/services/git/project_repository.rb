module Git
  # The bare Git repository behind a Project, opened with Rugged (libgit2).
  # Never shell out to the git binary from here.
  #
  # Layout of a project repository:
  #   project.json  (Scratch) or project.xml (Snap!), plain text, diffed and merged
  #   assets/<md5>.<ext>  Git LFS pointer files for costumes and sounds
  #   .gitattributes      routes assets/** through the LFS filter
  class ProjectRepository
    ROOT = Rails.root.join("storage", "repositories")

    attr_reader :project

    def initialize(project)
      @project = project
    end

    def path
      ROOT.join(project.owner.username, "#{project.slug}.git")
    end

    def exists?
      File.directory?(path)
    end

    def rugged
      @rugged ||= Rugged::Repository.bare(path.to_s)
    end

    # Creates the bare repository with an initial commit holding an empty project.
    def create!
      raise NotImplementedError
    end

    # Server-side fork for remixing: a new bare repository sharing history with this one.
    def fork_to!(other_project)
      raise NotImplementedError
    end

    def branches
      raise NotImplementedError
    end

    def commits(ref: "HEAD", limit: 50)
      raise NotImplementedError
    end

    # Reads a file at a ref, for example the project source for the editor.
    def read(path, ref: "HEAD")
      raise NotImplementedError
    end

    # Commits a new project source (and any changed LFS pointers) from the editor.
    def commit!(files:, message:, author:, branch: "main")
      raise NotImplementedError
    end

    # Diff for pull requests. Text files only; LFS pointers show as asset changes.
    def diff(base:, head:)
      raise NotImplementedError
    end
  end
end
