# $(document).ready ()->
#   $('select[id^=position_start_date]').change ()->
#     id = '#' + $(this).attr('id').replace('start', 'end')
#     $(id).find('option:selected').removeAttr('selected')
#     $(id).find('option[value=' + $(this).val() + ']').attr('selected', 'selected')

#   $('select#project_status').change ()->
#     value = $(this).val()
#     block = $('.control-group.end_date')
#     inputs = block.find('select')
#     if value == 'completed'
#       inputs.removeAttr('disabled')
#       block.show()
#     else
#       inputs.attr('disabled', 'disabled')
#       block.hide()
#   $('a[data-tooltip!=""]').qtip
#     content:
#        attr: 'data-tooltip'
