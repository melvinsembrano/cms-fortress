#= require tinymce-jquery

window.CMS.wysiwyg = ->
  tinymce.init
    selector: 'textarea[data-cms-rich-text]'
    menubar: 'tools format view'
    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table | fullscreen code | image fmedia link"
    plugins: ['code', 'fullscreen', 'media', 'link', 'table']
    link_list: CmsFortress.media.othersUrl()
    language : 'en',
    setup: (ed) ->
      ed.addButton 'image',
        title: 'Insert Image'
        onclick: ->
          CmsFortress.media.showImageDialog(ed)

      ed.addButton 'fmedia',
        tooltip: 'Insert Video'
        icon: 'media'
        stateSelector: ['img[data-mce-object=video]', 'img[data-mce-object=iframe]']
        onclick: ->
          CmsFortress.media.showVideoDialog(ed)



