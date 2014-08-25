jQuery ->
  $(document).on('ajax:success', '.user_adverts', (e, data, textStatus, xhr) ->
    $('.user_adverts_wrapper').append(data.adverts)
  )
