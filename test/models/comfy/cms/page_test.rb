require 'test_helper'

class Comfy::Cms::PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "drafted page can be reviewed" do
    @drafted = comfy_cms_pages(:drafted)
    @drafted.review
    assert(@drafted.reviewed?)
  end

  test "drafted page can be published" do
    @drafted = comfy_cms_pages(:drafted)
    @drafted.publish
    assert(@drafted.published?)
    assert(@drafted.is_published)
  end

  test "reviewed page can be published" do
    @reviewed = comfy_cms_pages(:reviewed)
    assert(!@reviewed.is_published)
    @reviewed.publish
    assert(@reviewed.published?)
    assert(@reviewed.is_published)
  end

  test "reviewed page can be drafted" do
    @reviewed = comfy_cms_pages(:reviewed)
    @reviewed.draft
    assert(@reviewed.drafted?)
  end

  test "published page can be drafted" do
    @published = comfy_cms_pages(:published)
    @published.draft
    assert(@published.drafted?)
    assert(!@published.is_published)
  end

  test "published page cannot be reviewed" do
    @published = comfy_cms_pages(:published)
    assert_raises (AASM::InvalidTransition) {
      @published.review!
    }
    assert(@published.is_published)
  end
end
