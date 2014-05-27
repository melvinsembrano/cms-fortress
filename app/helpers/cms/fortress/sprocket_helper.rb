module Cms::Fortress::SprocketHelper
  include TinyMCE::Rails::Helper

  def tinymce_init
    path = File.join(Rails.root, 'config', 'tinymce.yml')
    if File.exist?(path)
      config = YAML.load_file(path)
    else
      config = {}
    end

    options = {
      menubar: 'tools format view',
      toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table | fullscreen code',
      toolbar2: '',
      plugins: "['code', 'fullscreen', 'media', 'link', 'table']",
      language: 'en'
    }.stringify_keys.merge(config)

  <<-EOF
  tinymce.init({
      selector: 'textarea[data-cms-rich-text]',
      menubar: '#{ options['menubar'] }',
      toolbar1: '#{ options['toolbar1'] } | image fmedia link',
      toolbar2: '#{ options['toolbar2'] }',
      plugins: #{ options['plugins'] },
      link_list: CmsFortress.media.othersUrl(),
      language: '#{ options['language'] }',
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

end
