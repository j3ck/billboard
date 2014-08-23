jQuery ->
  $(document).on('ajax:success', '#add_advert', (e, data, textStatus, xhr) ->
    $(this).hide()
    $('.test').append(data.form_html)
    $('#new_advert').hide().fadeIn()

    $('#image_data').fileupload
      done: (e, data)->
        $(".images_wrapper").append(data.result.image_html)
  )

  $(document).on('click', '.close', () ->
    $('#new_advert').fadeOut().remove()
    $('#add_advert').fadeIn()
  )
