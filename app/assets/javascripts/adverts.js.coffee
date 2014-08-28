jQuery ->
  $(document).on('ajax:success', '#add_advert', (e, data, textStatus, xhr) ->
    $(this).hide()
    $('.test').append(data.form_html)
    $('.new_advert_wrapper').hide().fadeIn()

    $('.modal').show()

    $('#image_data').fileupload
      done: (e, data)->
        $(".images_wrapper").append(data.result.image_html)
  )

  $(document).on('click', '.close', () ->
    $('.new_advert_wrapper').fadeOut().remove()
    $('#add_advert').fadeIn()
  )

  $(document).on('ajax:success', '.delete-image', (e, data, textStatus, xhr) ->
    img_div = ".image-" + data.image_id
    $(e.target).closest(img_div).remove()
  )
