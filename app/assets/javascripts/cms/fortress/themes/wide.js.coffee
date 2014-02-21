#= require tinymce-jquery

window.CMS.wysiwyg = ->
  tinymce.init
    selector: 'textarea[data-cms-rich-text]'
    menubar: 'tools format view'
    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | fullscreen code | image fmedia"
    plugins: ['code', 'fullscreen', 'media']
    setup: (ed) ->
      ed.addButton 'image',
        title: 'Insert Image'
        onclick: ->
          media.showImageDialog(ed)

      ed.addButton 'fmedia',
        tooltip: 'Insert Video'
        icon: 'media'
        stateSelector: ['img[data-mce-object=video]', 'img[data-mce-object=iframe]']
        onclick: ->
          media.showVideoDialog(ed)



