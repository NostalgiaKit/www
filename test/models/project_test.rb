require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "remix knows where it came from" do
    assert_equal projects(:platformer), projects(:platformer_remix).forked_from
    assert_includes projects(:platformer).remixes, projects(:platformer_remix)
  end

  test "slug is unique per owner" do
    dup = Project.new(owner: users(:alice), name: "Again", slug: "platformer", editor: :scratch)
    assert_not dup.valid?
    assert Project.new(owner: users(:bob), name: "Again", slug: "platformer", editor: :scratch).valid?
  end

  test "repository lives under the owner's directory" do
    path = projects(:platformer).repository.path
    assert_equal Git::ProjectRepository::ROOT.join("alice", "platformer.git"), path
  end
end
