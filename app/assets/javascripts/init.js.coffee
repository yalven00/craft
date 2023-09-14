$(document).ready ->

  if $('#compensations').length
    Compensations.init()

  if $('#educations').length
    Educations.init()

  # if $('#industries').length
  #   Industries.init()

  # if $('#occupations').length
  #   Occupations.init()

  # if $('#market_salaries').length
  #   MarketSalary.init()

  if $('#static_pages').length
    StaticPages.init()

  if $('#companies').length
    Companies.init()

  if $('.profile').length == 0
    $('[data-toggle=collapse]').click (e)->
      e.preventDefault()
      $(this).find("i").toggleClass("fa-chevron-right fa-chevron-down")

  # checkboxes on the main page
  $("[type=checkbox]").change ()->
      $checkbox = $(this)
      $icon = $checkbox.siblings("[class*=fa-]")
      checked = $checkbox.is(":checked")
      $icon.toggleClass('fa-check-square-o', checked).toggleClass('fa-square-o', !checked)

$(document).ajaxStart ()->
  $('.ajax-loader').show()

$(document).ajaxStop ()->
  $('.ajax-loader').hide()
