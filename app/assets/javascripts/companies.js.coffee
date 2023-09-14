# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
class root.Companies extends root.Singleton

  @init: ->
    instance = @getInstance()
    instance.attach_events()
    instance.create_charts() if $('#companies #growth-tab').length

  attach_events: ->

    # check/uncheck all checkboxes by clicking on #all
    $('#companies .search input[type=checkbox][id=all]').change ()->
      checkboxes = $(this).closest('li').find('input[type=checkbox]')
      if($(this).is(':checked'))
        checkboxes.prop('checked', true)
      else
        checkboxes.prop('checked', false)

    $('#companies .search input[type=checkbox][id!=all]').change ()->
      if(!$(this).is(':checked'))
        $(this).closest('li').find('#all').prop('checked', false)

    # fill up category select when an industry is selected
    $('#companies .search select#company_industry_id').change ()->
      id = $(this).val()
      $.get('/categories/search', {search: {industry_id: id}}, 
        (data) ->
          select = $('#companies .search select#company_category_id')

          if data.length > 0
            html = '<option value="">All</option>'

            for item in data
              html += '<option value="' + item.id + '">' + item.name + '</option>'

            select.html(html)
            select.prop('disabled', false)
          else
            select.empty()
            select.prop('disabled', true)
        )

    $('#companies .grid .category a').popover delay: {show: 50, hide: 100}

    $('.tooltip').delay(4000).fadeOut('fast');

    $('#companies #company-info-tabs a').on 'shown.bs.tab', (e)->
      google.maps.event.trigger(map, 'resize')
      $(window).trigger('resize');

    fakewaffle.responsiveTabs(['xs'])

  create_charts: ->
    employees_div = $('#companies #growth-tab #employees')
    data = employees_div.data 'chart'

    employees_div.highcharts
      title:
        text: "Employees Growth"

      xAxis:
        categories: ["Month Ago", "Now"]

      yAxis:
        min: 0
        title:
          text: "Employees"

        plotLines: [
          value: 0
          width: 1
          color: "#808080"
        ]

      legend:
        enabled: false

      series: data

    followers_div = $('#companies #growth-tab #followers')
    data = followers_div.data 'chart'

    followers_div.highcharts
      title:
        text: "Twitter Followers"
        x: -20 #center

      xAxis:
        categories: ["Month Ago", "Now"]

      yAxis:
        min: 0
        title:
          text: "Twitter Followers"
        plotLines: [
          value: 0
          width: 1
          color: "#808080"
        ]

      legend:
        enabled: false

      series: data
