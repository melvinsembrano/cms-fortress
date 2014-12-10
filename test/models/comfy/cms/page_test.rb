require 'test_helper'

class Comfy::Cms::PageTest < ActiveSupport::TestCase

  test "new page can be drafted" do
    @new = comfy_cms_pages(:default)
    assert(@new.drafted?)
    assert(!@new.is_published)
  end

  test "new page can be reviewed" do
    @new = comfy_cms_pages(:default)
    @new.review
    assert(@new.reviewed?)
    assert(!@new.is_published)
  end

  test "new page can be published" do
    @new = comfy_cms_pages(:default)
    @new.publish
    assert(@new.published?)
    assert(@new.is_published)
  end

  test "drafted page can be reviewed" do
    @drafted = comfy_cms_pages(:drafted)
    @drafted.review
    assert(@drafted.reviewed?)
    assert(!@drafted.is_published)
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

  test "reviewed page can be resetted" do
    @reviewed = comfy_cms_pages(:reviewed)
    @reviewed.reset
    assert(@reviewed.drafted?)
  end

  test "reviewed page can be drafted" do
    @reviewed = comfy_cms_pages(:reviewed)
    assert_raises (AASM::InvalidTransition) {
      @reviewed.draft
    }
    assert(!@reviewed.is_published)
  end

  test "published page can be resetted" do
    @published = comfy_cms_pages(:published)
    @published.reset
    assert(@published.drafted?)
    assert(!@published.is_published)
  end

  test "published page can be drafted" do
    @published = comfy_cms_pages(:published)
    assert_raises (AASM::InvalidTransition) {
      @published.draft
    }
    assert(@published.is_published)
  end

  test "published page cannot be reviewed" do
    @published = comfy_cms_pages(:published)
    assert_raises (AASM::InvalidTransition) {
      @published.review
    }
    assert(@published.is_published)
  end
end
