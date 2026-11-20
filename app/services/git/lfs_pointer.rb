module Git
  # A Git LFS pointer file: https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md
  class LfsPointer < Data.define(:oid, :size)
    VERSION_LINE = "version https://git-lfs.github.com/spec/v1".freeze

    def self.parse(text)
      raise NotImplementedError
    end

    def to_s
      "#{VERSION_LINE}\noid sha256:#{oid}\nsize #{size}\n"
    end
  end
end
