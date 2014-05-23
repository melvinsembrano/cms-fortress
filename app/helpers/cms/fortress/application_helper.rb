module Cms::Fortress::ApplicationHelper
  def role_display(command)
    res = command.split(".")
    raw "#{content_tag(:strong, res.first.titleize) } / #{ res[1..-1].map {|r| r.titleize}.join(" - ") }"
  end

  def theme_name
    Cms::Fortress.configuration.theme.to_s
  end

  def default_theme?
    theme_name.to_s.eql?('default')
  end

  def themed_partial(partial)
    render partial: "cms/fortress/themes/#{ theme_name }/#{ partial }"
  end

  def back_path
    case controller_name
    when "pages"
      comfy_admin_cms_site_pages_path
    when "files"
      comfy_admin_cms_site_files_path
    when "layouts"
      comfy_admin_cms_site_layouts_path
    when "snippets"
      comfy_admin_cms_site_snippets_path
    else
      ""
    end
  end

  def media_files_path(type)
    if params[:site_id]
      if type.eql?(:image)
        cms_fortress_files_images_path
      elsif type.eql?(:video)
        cms_fortress_files_videos_path
      else
        cms_fortress_files_others_url(format: :json)
      end
    end
  end

  def image_item(m)
    styles = {original: m.file.url}
    m.file.styles.keys.each {|k,v| styles[k] = m.file.url(k) }
    link_to image_tag(m.file.url(:cms_thumb), alt: m.label, class: 'editor-image', data: styles), "#"
  end

  def image_styles(m)
    links = []
    links << link_to("Original", m.file.url, class: 'label label-primary editor-image-style', target: '_blank', title: "Select original size")
    i = 0
    m.file.styles.each {|k,v| links << link_to("#{ i+=1 }", m.file.url(k), class: 'label label-primary editor-image-style', target: '_blank', title: "Select #{ k.to_s.titleize }") }
    raw links.join(" ")
  end

  def topnav_item(title, path, is_current = false)
    css_class = is_current ? "active" : ""
    content_tag(:li, link_to(title, path), class: css_class)
  end

  def leftnav_item(title, path, options = {})
    content_tag(:li, active_link_to(title, path, options))
  end


  def admin_page?
    controller_name.eql?('admin') && %w{roles users}.include?(action_name) ||
      Cms::Fortress.configuration.settings_resources.
        map { |resource| resource[:name] }.
        include?(controller_name)
  end

  def design_page?
    Cms::Fortress.configuration.design_resources.
        map { |resource| resource[:name] }.
        include?(controller_name)
  end

  def content_page?
    Cms::Fortress.configuration.content_resources.
        map { |resource| resource[:name] }.
        include?(controller_name)
  end
end

