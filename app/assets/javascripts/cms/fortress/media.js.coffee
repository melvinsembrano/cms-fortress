window.media =
  init: ->
    this.dlg = $("#media-box-dialog")
    # this.dlg.modal(show: false, backdrop: false)

  showImageDialog: (ed) ->
    this.ed = ed
    this.dlg.modal(show: true, backdrop: false)
      .css("left", $(document).width() - (this.dlg.width() / 2))
      .find(".title").html("Image Selector")

    $("#modal-body").load this.imagesPath, ->
      media.attachImageEvents()



  showVideoDialog: (ed) ->
    console.info "showing video dialog here.."

  attachImageEvents: ->
    $('.editor-image').on 'click', ->
      data = $(this).data()
      url = data.original

      media.attachImage(url)

    $('.editor-image-style').on 'click', (e)->
      media.attachImage($(this).attr("href"))
      e.preventDefault()



  attachImage: (url) ->
    this.ed.focus()
    img = "<img src='#{ url }'>"
    this.ed.selection.setContent(img)



$(document).ready ->
  media.init()
