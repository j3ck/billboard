jQuery ->
  $(document).on('ajax:success', '.get_modal', (e, data, textStatus, xhr) ->
    $('body').append(data.html)
    $('.modal').show()
  )

  $(document).on('click', '.close', () ->
    $('.modal').remove()
  )
