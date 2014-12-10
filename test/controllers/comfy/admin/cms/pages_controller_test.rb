require 'test_helper'

class Comfy::Admin::Cms::PagesControllerTest < ActionController::TestCase
  def setup
    @comfy_cms_site = comfy_cms_sites(:default)
    @cms_fortress_user = cms_fortress_users(:one)
    @cms_fortress_role = cms_fortress_roles(:one)
    sign_in Cms::Fortress::User, @cms_fortress_user
  end

  test "new page should be drafted" do
    assert_difference 'Comfy::Cms::Page.count' do
      assert_difference 'Comfy::Cms::Block.count', 2 do
        post :create, :site_id => @comfy_cms_site, :page => {
            :label          => 'Test Page',
            :slug           => 'test-page',
            :parent_id      => comfy_cms_pages(:default).id,
            :layout_id      => comfy_cms_layouts(:default).id,
            :blocks_attributes => [
                { :identifier => 'default_page_text',
                  :content    => 'content content' },
                { :identifier => 'default_field_text',
                  :content    => 'title content' }
            ]
        }
        page = Comfy::Cms::Page.last
        assert_equal @comfy_cms_site, page.site
        assert page.drafted?
        assert_redirected_to edit_comfy_admin_cms_site_page_url(id: page, site_id: page.site)
        assert_equal 'Page created', flash[:success]
      end
    end
  end

  test "new page should be published" do
    assert_difference 'Comfy::Cms::Page.count' do
      assert_difference 'Comfy::Cms::Block.count', 2 do
        post :create, :site_id => @comfy_cms_site, :page => {
            :label          => 'Test Page',
            :slug           => 'test-page',
            :parent_id      => comfy_cms_pages(:default).id,
            :layout_id      => comfy_cms_layouts(:default).id,
            :blocks_attributes => [
                { :identifier => 'default_page_text',
                  :content    => 'content content' },
                { :identifier => 'default_field_text',
                  :content    => 'title content' }
            ]
        }, :transition => 'publish'
        page = Comfy::Cms::Page.last
        assert_equal @comfy_cms_site, page.site
        assert page.published?
        assert_redirected_to edit_comfy_admin_cms_site_page_url(id: page, site_id: page.site)
        assert_equal 'Page created', flash[:success]
      end
    end
  end

  test "drafted page should become reviewed" do
    page = comfy_cms_pages(:drafted)
    assert_no_difference 'Comfy::Cms::Block.count' do
      put :update, :site_id => page.site, :id => page, :transition => 'review'
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => page
      assert_equal 'Page updated', flash[:success]
      assert assigns(:page).reviewed?
    end
  end

  test "drafted page should become published" do
    page = comfy_cms_pages(:drafted)
    assert_no_difference 'Comfy::Cms::Block.count' do
      put :update, :site_id => page.site, :id => page, :transition => 'publish'
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => page
      assert_equal 'Page updated', flash[:success]
      assert assigns(:page).published?
    end
  end

  test "reviewed page should become published" do
    page = comfy_cms_pages(:reviewed)
    assert_no_difference 'Comfy::Cms::Block.count' do
      put :update, :site_id => page.site, :id => page, :transition => 'publish'
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => page
      assert_equal 'Page updated', flash[:success]
      assert assigns(:page).published?
    end
  end

  test "published page should become drafted" do
    page = comfy_cms_pages(:published)
    assert_no_difference 'Comfy::Cms::Block.count' do
      put :update, :site_id => page.site, :id => page, :transition => 'reset'
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => page
      assert_equal 'Page updated', flash[:success]
      assert assigns(:page).drafted?
    end
  end

  test "saving a page should'nt change status of a page" do
    page = comfy_cms_pages(:drafted)
    label = 'Arrr'
    put :update, :site_id => page.site, :id => page, :commit => 'save', :page => {
        :label          => label,
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => page
    assert_equal 'Page updated', flash[:success]
    assert assigns(:page).drafted?
    assert_equal assigns(:page).label, label
  end
end
