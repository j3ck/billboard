jQuery ->
  $(document).on('ajax:success', '#add_advert', (e, data, textStatus, xhr) ->
    $(this).hide()
    $('.test').append(data.form_html)
    $('#new_advert').hide().fadeIn()
  )

  $(document).on('click', '.close', () ->
    $('#new_advert').fadeOut().remove()
    $('#add_advert').fadeIn()
  )
