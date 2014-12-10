window.media =
  init: ->
    this.dlg = $("#media-box-dialog")
    # this.dlg.modal(show: false, backdrop: false)
    @eventListeners()

  eventListeners: ->
    ($ 'button.js-blank').on 'click', (e) =>
      ($ e.target).closest('form').attr('target', '_blank')

  loading: "<p>Loading...</p>"

  othersUrl: ->
    this.othersPath

  showImageDialog: (ed) ->
    this.ed = ed
    this.dlg.modal(show: true, backdrop: false)
      #.css("left", $(document).width() - (this.dlg.width() / 2))
      .find(".title").html("Image Selector")

    $("#modal-body").html(this.loading).load this.imagesPath, ->
      media.attachImageEvents()



  showVideoDialog: (ed) ->
    this.ed = ed
    this.dlg.modal(show: true, backdrop: false)
      #.css("left", $(document).width() - (this.dlg.width() / 2))
      .find(".title").html("Video Selector")

    $("#modal-body").html(this.loading).load this.videosPath, ->
      media.attachVideoEvents()


  attachVideoEvents: ->
    $('.editor-video').on 'click', (e)->
      e.preventDefault()
      media.attachVideo($(this).attr("href"), $(this).data('contentType'))
      media.dlg.modal('hide')


  attachImageEvents: ->
    $('.editor-image').on 'click', ->
      data = $(this).data()
      url = data.original

      media.attachImage(url)
      media.dlg.modal('hide')

    $('.editor-image-style').on 'click', (e)->
      media.attachImage($(this).attr("href"))
      e.preventDefault()
      media.dlg.modal('hide')



  attachImage: (url) ->
    this.ed.focus()
    img = "<img src='#{ url }'>"
    this.ed.selection.setContent(img)

  attachVideo: (url, type) ->
    this.ed.focus()
    img = '<img class="mce-object mce-object-video" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" width="320" height="240" data-mce-p-controls="controls" data-mce-html="%0A%3Csource%20src%3D%22' + url + '%22%20/%3E%0A" data-mce-object="video">'
    this.ed.selection.setContent(img)
    this.ed.nodeChanged()

window.CmsFortress = window.CmsFortress || {}

window.CmsFortress.media = media

$(document).ready ->
  CmsFortress.media.init()
