# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
# $(document).ready ()->
#   $('#desired_jobs').on 'click', 'a.add-field', (e) ->
#     e.preventDefault()
#     html = '<div class="control-group"><div class="control"><select id="field" name="field"><option value="company">Company</option><option value="industry">Industry</option><option value="title">Title</option><option value="location">Location</option><option value="link">Link</option><option value="description">Description</option></select><input id="desired_job_company" name="desired_job[company]" value="" type="text"><a class="remove-field" href="#">Remove field</a></div></div>'
#     $(this).before(html)

#   $('#desired_jobs').on 'change', 'select#field', ()->
#     input = $(this).parent().find('input')
#     value = $(this).val()
#     input.attr 'name', 'desired_job[' + value + ']'
#     input.attr 'id', 'desired_job_' + value

#   $('#desired_jobs').on 'click', 'a.remove-field', (e)->
#     e.preventDefault()
#     block = $(this).parents('.control-group')
#     if block.hasClass('edit')
#       block.hide()
#       $(this).parent().find('input').val('')
#     else
#       block.remove()
