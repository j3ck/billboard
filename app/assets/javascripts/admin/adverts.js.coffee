jQuery ->
  $(document).on('ajax:success', '.user_adverts', (e, data, textStatus, xhr) ->
    $('.user_adverts_wrapper').append(data.adverts)
  )

  $(document).on('ajax:success', '.action_publish', (e, data, textStatus, xhr) ->
    advert_class = ".advert-"+data.advert_id
    $('.modal').modal('hide').remove()
    $(advert_class).fadeOut('slow', () ->
      $(this).remove()
    )
  )
