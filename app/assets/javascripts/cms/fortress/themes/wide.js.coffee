#= require tinymce

window.CMS.wysiwyg = ->
  tinymce.init
    selector: 'textarea[data-cms-rich-text]'
    menubar: 'tools format view'
    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | image media"
    plugins: ['code', 'media']
    setup: (ed) ->
      ed.addButton 'image',
        title: 'Image Media'
        onclick: ->
          media.showImageDialog(ed)

      ed.addButton 'media2',
        title: 'Video'
        onclick: ->
          media.showImageDialog(ed)



