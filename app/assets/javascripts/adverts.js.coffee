jQuery ->
  $('#image_data').fileupload
    start: (e)->
      $('.progress').show()
    done: (e, data)->
      $(".images_wrapper").append(data.result.image_html)
      $('.progress').hide()
      $('.progress-bar').css('width', '0%' )
      $('#upload-image').button('reset')
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
