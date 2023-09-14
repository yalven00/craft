# TODO: refactor

$(document).ready ()->
  $('#education_start_year').change ()->
    end_select = $('#education_end_year')
    term_select = $('select[id^=education_terms_attributes]')
    start_year = $(this).val()
    html = ('<option value=' + year + '>' + year + '</option>' for year in [start_year..start_year * 1 + 15])
    term_select.html(html)
    end_select.html(html)

  $('#education_end_year').change ()->
    term_select = $('select[id^=education_terms_attributes]')
    start_year = $('#education_start_year').val()
    end_year = $(this).val()
    html = ('<option value=' + year + '>' + year + '</option>' for year in [start_year..end_year])
    term_select.html(html)

  $(document).on 'click', '#save-term, #save-class', (e)->
    e.preventDefault()
    form = $('form[id*=education]')
    $.ajax 
      url: form.attr('action'),
      type: form.attr('method'),
      dataType: 'script',
      data: form.serialize()

  $(document).on 'nested:fieldAdded:terms', (event)->
    field = event.field
    term_select = field.find('select')
    start = $('#education_start_year').val() || '1950'
    end = $('#education_end_year').val() || '2020'
    html = ('<option value=' + year + '>' + year + '</option>' for year in [start..end])
    term_select.html(html)
