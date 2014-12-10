module Cms::Fortress::SprocketHelper
  include TinyMCE::Rails::Helper

  def tinymce_init
    config = Cms::Fortress::Settings.new(:tinymce).to_h rescue {}

    options = {
      menubar: "tools format view",
      toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table | fullscreen code | image fmedia link",
      toolbar2: "",
      plugins: ["code", "fullscreen", "media", "link", "table"],
      language: "en"
    }.merge(config)

  <<-EOF
  tinymce.init({
      #{configuration_from_options(options)}
      #{configuration_from_options_as_string(options)}
      selector: 'textarea[data-cms-rich-text]',
      link_list: CmsFortress.media.othersUrl(),

      setup: function(ed) {
        ed.addButton('image', {
          title: 'Insert Image',
          onclick: function() {
            return CmsFortress.media.showImageDialog(ed);
          }
        });

        return ed.addButton('fmedia', {
          tooltip: 'Insert Video',
          icon: 'media',
          stateSelector: ['img[data-mce-object=video]', 'img[data-mce-object=iframe]'],
          onclick: function() {
            return CmsFortress.media.showVideoDialog(ed);
          }
        });
      }
    });
  EOF
  end

  private

  def configuration_from_options_as_string(options)
    config = options.map do |k, v|
      "#{k.to_s.gsub('[plain]', '')}: #{v}," if k.to_s =~ /\[plain\]/
    end
    config.join() if config.present?
  end

  def configuration_from_options(options)
    config = options.map do |k, v|
      unless k.to_s =~ /\[plain\]/
        v.is_a?(Array) ? "#{k}: #{v}," : "#{k}: #{boolean_value(v)},"
      end
    end
    config.join()
  end

  def boolean_value(v)
    [true, false].include?(v) ? "#{v}" : "'#{v}'"
  end
end
