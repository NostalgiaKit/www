require "test_helper"

# Every server-rendered page renders. Placeholders count; errors do not.
class PagesSmokeTest < ActionDispatch::IntegrationTest
  setup do
    @alice = users(:alice)
    @project = projects(:platformer)
  end

  test "site pages" do
    [ root_path, explore_path, forum_topics_path, forum_topic_path(forum_topics(:welcome)), user_path(@alice) ].each do |path|
      get path
      assert_response :success, path
    end
  end

  test "project pages" do
    [
      user_project_path(@alice, @project),
      user_project_tree_path(@alice, @project),
      user_project_commits_path(@alice, @project),
      user_project_commit_path(@alice, @project, "abc123"),
      user_project_pull_requests_path(@alice, @project),
      user_project_pull_request_path(@alice, @project, pull_requests(:double_jump)),
      user_project_issues_path(@alice, @project),
      user_project_issue_path(@alice, @project, issues(:stuck_in_wall)),
      user_project_blueprints_path(@alice, @project),
      user_project_blueprint_path(@alice, @project, blueprints(:level_editor)),
      user_project_editor_path(@alice, @project),
      user_project_editor_path(@alice, projects(:snap_lists))
    ].each do |path|
      get path
      assert_response :success, path
    end
  end

  test "web shell ships no JavaScript" do
    get user_project_path(@alice, @project)
    assert_select "script", count: 0
  end

  test "forum posts escape HTML" do
    get forum_topic_path(forum_topics(:welcome))
    assert_no_match "<script>alert", response.body
  end

  test "unknown project is a 404" do
    get "/~alice/nope"
    assert_response :not_found
  end

  test "sb3 export is not implemented yet" do
    get user_project_export_path(@alice, @project)
    assert_response :not_implemented
  end

  test "lfs batch endpoint is routed" do
    post git_lfs_batch_path(user_username: "alice", project_slug: "platformer")
    assert_response :not_implemented
  end
end
