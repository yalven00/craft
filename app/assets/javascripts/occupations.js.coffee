# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
# root = exports ? this
# class root.Occupations extends root.Singleton

#   @init: ->
#     instance = @getInstance()
#     instance.attach_events()

#   attach_events: ->
#     $('#occupations #search_area').autocomplete
#       source: '/occupations/areas'
#       minLength: 4

#     $('#occupations #search_title').autocomplete
#       source: '/occupations/titles'
#       minLength: 4

#   create_charts: ->
#     employment_data = $('#occupations #employment').data 'employment'

#     $('#occupations #employment').highcharts
#       chart:
#         type: 'column'

#       title:
#         text: 'Peolpe Employed (000)'

#       xAxis:
#         categories: ['2010', 'Expected Change', '2020']
#         title:
#           text: null

#       yAxis:
#         min: 0
#         title:
#           text: null

#         labels:
#           overflow: 'justify'

#       plotOptions:
#         column:
#           stacking: 'normal',
#           color: '#adc76a'

#       legend:
#         enabled: false

#       credits:
#         enabled: false

#       series: employment_data


#     jobs_data = $('#occupations #jobs').data 'jobs'

#     $('#occupations #jobs').highcharts
#       chart:
#         type: 'column'

#       title:
#         text: 'Average Job Openings (000)'

#       xAxis:
#         categories: ['Jobs']
#         title:
#           text: null

#       yAxis:
#         min: 0
#         title:
#           text: null

#         labels:
#           overflow: 'justify'

#       plotOptions:
#         column:
#           dataLabels:
#             enabled: true
#           color: '#adc76a'

#       legend:
#         enabled: false

#       credits:
#         enabled: false

#       series: jobs_data


#     salary_data = $('#occupations #salary-range').data 'salary-range'
#     $('#occupations #salary-range').highcharts
#       title:
#         text: "Annual Salary Range"
#         x: -20

#       xAxis:
#         categories: ['10%', '25%', 'Median', '75%', '90%']

#       yAxis:
#         title:
#           text: null

#         plotLines: [
#           value: 0
#           width: 1
#           color: "#808080"
#         ]

#       tooltip:
#         valueSuffix: "$"

#       legend:
#         enabled: false

#       series: salary_data
