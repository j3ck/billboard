jQuery ->
  $('#image_data').fileupload
    start: (e)->
      $('.progress').show()
      $('.img-btn-text').text("Uploading...")
      $('.btn-file').addClass('disabled')
    done: (e, data)->
      $(".images_wrapper").append(data.result.image_html)
      $('.progress').hide()
      $('.progress-bar').css('width', '0%' )
      $('.img-btn-text').text("add image file")
      $('.btn-file').removeClass('disabled')
    progressall: (e, data)->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.progress-bar').css(
          'width',
          progress + '%'
      )

  $(document).on('ajax:success', '.delete-image', (e, data, textStatus, xhr) ->
    img_div = ".image-" + data.image_id
    $(e.target).closest(img_div).remove()
  )

  $(".chosen").chosen
    allow_single_deselect: true,
    width: "95%"
