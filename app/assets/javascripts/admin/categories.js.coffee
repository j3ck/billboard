jQuery ->
  $(document).on('ajax:success', '.new_category', (e, data, textStatus, xhr) ->
    if (data.create_status)
      $('.categories_wrapper').prepend(data.category_html)
      $('#categoryModal').modal('hide').remove()
    else
      $('#categoryModal').modal('hide')
      $('#categoryModal').replaceWith(data.form_html)
      $('#categoryModal').modal('show')
  )

  $(document).on('ajax:success', '.edit_category', (e, data, textStatus, xhr) ->
    if (data.create_status)
      category = ".category-" + data.id
      $(category).replaceWith(data.category_html)
      $('#categoryModal').modal('hide').remove()
    else
      $('#categoryModal').modal('hide')
      $('#categoryModal').replaceWith(data.form_html)
      $('#categoryModal').modal('show')
  )
