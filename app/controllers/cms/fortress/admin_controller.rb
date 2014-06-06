class Cms::Fortress::AdminController < Comfy::Admin::Cms::BaseController

  def dashboard

  end

  def roles
    @roles = Role.all
  end

  def images
    @files = Comfy::Cms::File.images
    respond_to do |format|
      format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files, type: :image} }
      format.json { render json: @files }
    end
  end

  def videos
    @files = Comfy::Cms::File.videos
    respond_to do |format|
      format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files, type: :video} }
      format.json { render json: @files }
    end
  end

  def other_files
    @files = Comfy::Cms::File.others.map {|f| {title: f.label, value: f.file.url}}
    respond_to do |format|
      format.html { render partial: 'cms/fortress/shared/media_items', locals: {media: @files, type: :others} }
      format.json { render json: @files }
    end
  end
end
