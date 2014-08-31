jQuery ->
  $('#image_data').fileupload
    done: (e, data)->
      $(".images_wrapper").append(data.result.image_html)

  $(document).on('ajax:success', '.delete-image', (e, data, textStatus, xhr) ->
    img_div = ".image-" + data.image_id
    $(e.target).closest(img_div).remove()
  )

  $(".chosen").chosen
    allow_single_deselect: true,
    width: "95%"
