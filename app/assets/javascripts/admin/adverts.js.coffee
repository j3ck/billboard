jQuery ->
  $(document).on('ajax:success', '.action_publish', (e, data, textStatus, xhr) ->
    advert_class = ".advert-"+data.advert_id
    $('.modal').modal('hide').remove()
    $(advert_class).fadeOut('slow', () ->
      $(this).remove()
    )
  )

  $(document).on('ajax:success', '#new_log', (e, data, textStatus, xhr)->
    if (data.create_status)
      advert_class = ".advert-" + data.advert_id
      $('#logModal').modal('hide').remove()
      $(advert_class).fadeOut('slow', ()->
        $(this).remove()
      )
    else
      $('#logModal').modal('hide')
      $('#logModal').replaceWith(data.html)
      $('#logModal').modal('show')
  )
