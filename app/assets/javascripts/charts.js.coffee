# $(document).ready ()->
#   salary_progression = $('#salary-progression')
#   consulting_comparison = $('#consulting-comparison')
#   full_time_compensations = $('#full-time-compensations')
#   currencies = $('#currency-charts')
#   consulting_total_cash = $('#consulting-total-cash')



#   # Consulting Comparison by Client
#   if consulting_comparison.length > 0
#     labels = consulting_comparison.data 'labels'
#     data = consulting_comparison.data 'data'

#     consulting_comparison.highcharts
#       chart:
#           type: 'column'
#       title:
#           text: 'Consulting Pay Comparison by Client'
#       xAxis:
#           categories: labels
#       yAxis:
#           title:
#               text: 'Day rate equivalent'
#       series: [{data: data}]
#       tooltip:
#         formatter: ()->
#           this.x + "<br />" + this.y
#       plotOptions:
#         column:
#           color: '#adc76a'
#       legend:
#         enabled: false



#   # Salary progression
#   if salary_progression.length > 0
#       labels = salary_progression.data 'labels'
#       progression = salary_progression.data 'progression'
#       compensations = salary_progression.data 'compensations'

#       salary_progression.highcharts
#         title:
#           text: "Total Salary Progression"

#         xAxis:
#           categories: labels

#         yAxis: [
#           title:
#             text: "Yoy Growth"
#             style:
#               color: "#89A54E"
#         ,
#           title:
#             text: "Total Cash Compensation"
#             style:
#               color: "#4572A7"

#           opposite: true
#         ]
#         tooltip:
#           shared: true

#         series: [
#           name: "Total Cash Compensation"
#           color: "#4572A7"
#           type: "column"
#           yAxis: 1
#           data: compensations
#         ,
#           name: "Yoy Growth"
#           color: "#89A54E"
#           type: "spline"
#           data: progression
#         ]
#         legend:
#           enabled: false


#   # Full time Positions (USD)
#   if full_time_compensations.length > 0
#     labels = full_time_compensations.data 'labels'
#     compensations = full_time_compensations.data 'compensations'
#     Highcharts.theme = {colors: ['#4572A7', '#89A54E']}
#     highchartsOptions = Highcharts.setOptions(Highcharts.theme);

#     full_time_compensations.highcharts
#       chart: 
#         type: 'column'
#       title: 
#         text: 'Full-Time Positions (USD)'
#       xAxis:
#         categories: labels
#       yAxis:
#         min: 0,
#         stackLabels:
#           enabled: true,
#           style:
#             fontWeight: 'bold',
#             color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
#       legend:
#         enabled: false
#       tooltip:
#         formatter: () ->
#           '<b>' + this.x + '</b><br/>' + this.series.name + ': $' + this.y + '<br/>' + 'Total: $' + this.point.stackTotal;
#       plotOptions:
#         column:
#           stacking: 'normal',
#           dataLabels:
#             enabled: true,
#             color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
#       series: compensations



#   # Consulting Total Cash
#   if consulting_total_cash.length > 0
#     labels = consulting_total_cash.data 'labels'
#     data = consulting_total_cash.data 'data'

#     consulting_total_cash.highcharts
#       chart:
#           type: 'column'
#       title:
#           text: 'Consulting Total Cash Comparison'
#       xAxis:
#           categories: labels
#       yAxis:
#           title:
#               text: 'Total Cash'
#       series: [{data: data}]
#       tooltip:
#         formatter: ()->
#           this.x + "<br />" + this.y
#       plotOptions:
#         column:
#           color: '#adc76a'
#       legend:
#         enabled: false


#   # Currencies
#   if currencies.length > 0
#     currencies.find('#gbp, #btc, #eur').each ()->
#       name = $(this).data 'name'
#       data = $(this).data 'data'
#       labels = $(this).data 'labels'

#       $(this).highcharts
#         title:
#           text: 'Monthly Average Exchange Rate',
#           x: -20
#         xAxis:
#           categories: labels
#         yAxis:
#           title:
#             text: 'USD'
#         plotLines: [{value: 0, width: 1, color: '#808080'}]
#         legend:
#           layout: 'vertical',
#           align: 'right',
#           verticalAlign: 'middle',
#           borderWidth: 0
#         series: [{name: name, data: data}]
