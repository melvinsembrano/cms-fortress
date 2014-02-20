#= require tinymce-jquery

window.CMS.wysiwyg = ->
  tinymce.init
    selector: 'textarea[data-cms-rich-text]'
    menubar: 'tools format view'
    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | fullscreen code | image media"
    plugins: ['code', 'fullscreen']
    setup: (ed) ->
      ed.addButton 'image',
        title: 'Image Media'
        onclick: ->
          media.showImageDialog(ed)

      ed.addButton 'media',
        title: 'Video'
        onclick: ->
          media.showVideoDialog(ed)



