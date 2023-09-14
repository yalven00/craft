root = exports ? this
class root.Compensations extends root.Singleton

  @init: ->
    instance = @getInstance()
    instance.attach_consulting_events()
    instance.attach_full_time_events()
  
  caltulate_total: (id) ->
    total_base = $("#compensation_base_salary").val() or 0
    second_field = $(id).val() or 0 # id should be 'bonus' or 'actual paid'
    total = parseInt(total_base) + parseInt(second_field)
    $("#compensation_total").val total

  calculate_base: ->
    rate = $("#compensation_rate").val()
    number = $("#compensation_number").val()
    salary = rate * number
    base_salary = $("#compensation_base_salary")
    base_salary.val salary
    base_salary.change()

  calculate_annual_equivalent: ->
    rate_type = $("#compensation_rate_type").val()
    rate = $("#compensation_rate").val()
    rates =
      Hour: 8 * 250
      Day: 250
      Week: 50
      Month: 12
      "Full Project": 1

    annual_equivalent = rate * rates[rate_type]
    $("#compensation_annual_equivalent").val annual_equivalent

  calculate_percent_of_target: ->
    target = $("#compensation_target").val() or 0
    actual_paid = $("#compensation_actual_paid").val() or 0
    total = parseInt((parseInt(actual_paid) / parseInt(target)) * 100)
    $("#compensation_percent_of_target").val total

  attach_full_time_events: ->
    $("#compensations").on 'change', "tr.full_time #compensation_base_salary,  tr.full_time #compensation_actual_paid", () ->
      Compensations.getInstance().caltulate_total("#compensation_actual_paid")

    $("#compensations").on 'change', "tr.full_time #compensation_target, tr.full_time #compensation_actual_paid", () ->
      Compensations.getInstance().calculate_percent_of_target()

  attach_consulting_events: ->
    $("#compensations").on 'change', "tr.consulting #compensation_rate", () ->
      Compensations.getInstance().calculate_base()
      Compensations.getInstance().calculate_annual_equivalent()

    $("#compensations").on 'change', "tr.consulting #compensation_number", () ->
      Compensations.getInstance().calculate_base()

    $("#compensations").on 'change', "tr.consulting #compensation_bonus, #compensation_base_salary", () ->
      Compensations.getInstance().caltulate_total("#compensation_bonus")

    $("#compensations").on 'change', "tr.consulting #compensation_rate_type", () ->
      Compensations.getInstance().calculate_annual_equivalent()

$(document).ready ->
  $("input[name='bonus'], input[name='equity']").change ->
    cls = $(this).attr("name")
    elements = $("." + cls)
    if $(this).val() == 'off'
      elements.slideUp() # Hide elements
    else
      elements.slideDown() # Display elements

  $("#autocomplete").autocomplete
    source: "/salary/compare"
    minLength: 4

  $("#conpensations form.search input[type='submit']").click (e) ->
    e.preventDefault()
    states = []
    $(this).parent().find("input[type='checkbox']:checked").each ->
      states.push $(this).attr("name")

    $.ajax "/salary/compare",
      dataType: "script"
      type: "GET"
      data:
        search:
          states: states
          title: $("#autocomplete").val()

  $('#compensations').on 'click', '.update-compensation, .create-compensation', (e) ->
    e.preventDefault()
    if $(this).hasClass('create-compensation')
      method = 'POST'
    else 
      method = 'PUT'
    row = $(this).parents('tr')
    id = row.attr('id') || ''
    url = '/salary/' + id
    data = row.find(':input').serialize()
    $.ajax url,
      type: method,
      data: data,
      dataType: 'script'

  $('#compensations').on 'mouseenter', '#compensation_start_date, #compensation_end_date', () ->
    $(this).datepicker
      dateFormat: 'yy-mm-dd'
