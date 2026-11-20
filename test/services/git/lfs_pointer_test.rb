require "test_helper"

class Git::LfsPointerTest < ActiveSupport::TestCase
  test "writes the spec format" do
    pointer = Git::LfsPointer.new(oid: "a" * 64, size: 12)
    assert_equal "version https://git-lfs.github.com/spec/v1\noid sha256:#{"a" * 64}\nsize 12\n", pointer.to_s
  end
end
