require "test_helper"

class LfsObjectTest < ActiveSupport::TestCase
  test "fixture is valid" do
    assert lfs_objects(:empty).valid?
  end

  test "oid must be a SHA-256 hex digest" do
    assert_not LfsObject.new(oid: "abc", md5: lfs_objects(:empty).md5, size: 0).valid?
  end
end
