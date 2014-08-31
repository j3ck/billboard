jQuery ->
  $(document).on('ajax:success', '.get_modal', (e, data, textStatus, xhr) ->
    $('body').append(data.html)
    $('.modal').modal
      keyboard: false,
      backdrop: 'static'
  )

  $(document).on('click', '.close', () ->
    $('.modal').remove()
  )
