# root = exports ? this
# class root.Industries extends root.Singleton

#   @init: ->
#     instance = @getInstance()
#     instance.attach_events()

#   attach_events: ->
#     $('#industries #search_area').autocomplete
#       source: '/industries/areas'
#       minLength: 4

#   manage_tweet_updater: (industry)->
#     clearInterval(@update_interval)
#     @set_tweet_updater(industry)
  
#   set_tweet_updater: (industry)->
#     @update_interval = setInterval(()->
#         $.get('/industries/update_tweets', {industry: industry})
#       , 60000)

#   create_charts: ->
#     employment_data = $('#industries #employment').data 'employment'

#     $('#industries #employment').highcharts
#       chart:
#         type: 'column'

#       title:
#         text: 'People Employed (000)'

#       xAxis:
#         categories: ['2010', '2011', '2012']
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

#       series: employment_data


#     outlets_data = $('#industries #outlets').data 'outlets'

#     $('#industries #outlets').highcharts
#       chart:
#         type: 'column'

#       title:
#         text: 'Number of Outlets'

#       xAxis:
#         categories: ['2010', '2011', '2012']
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

#       series: outlets_data


#     salary_data = $('#industries #average-salary').data 'average-salary'

#     $('#industries #average-salary').highcharts
#       chart:
#         type: 'column'

#       title:
#         text: 'Average Salary'

#       xAxis:
#         categories: ['2010', '2011', '2012']
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
#             formatter: () ->
#               return '$' + this.y
#           color: '#adc76a'

#       legend:
#         enabled: false

#       credits:
#         enabled: false

#       series: salary_data
