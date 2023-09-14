# $(document).ready ()->
#   $('select[id^=project_start_date]').change ()->
#     id = '#' + $(this).attr('id').replace('start', 'end')
#     $(id).find('option:selected').removeAttr('selected')
#     $(id).find('option[value=' + $(this).val() + ']').attr('selected', 'selected')

#   $('#positions').on 'mouseenter', '#project_start_date, #project_end_date', () ->
#     $(this).datepicker
#       dateFormat: 'yy-mm-dd'

#   $('#projects').on 'click', '.update-project, .create-project', (e) ->
#     e.preventDefault()
#     if $(this).hasClass('create-project')
#       method = 'POST'
#     else
#       method = 'PUT'
#     row = $(this).parents('tr')
#     id = row.attr('id') || ''
#     url = '/projects/' + id
#     data = row.find(':input').serialize()
#     $.ajax url,
#       type: method,
#       data: data,
#       dataType: 'script'

#   $('#positions').popover
#     selector: '.show-assets',
#     title: 'Assets',
#     html: true,
#     content: () ->
#       $(this).parent().find('.assets-popover').html()

#   $('#positions table').popover
#     selector: '.new-asset',
#     title: 'Add asset',
#     html: true,
#     content: () ->
#       $(this).parent().find('.new-asset-popover').html()

#   $('.popover-content').on 'click', '#new-asset input[type="submit"]', ()->
#     form = $(this).parent()
#     $.post(form.attr('action'),{data: form.serialize(), method: 'POST', dataType: 'script'})
