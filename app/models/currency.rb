# require 'csv'
# class Currency < ActiveRecord::Base
#   ['GBP', 'EUR', 'BTC'].each do |currency|
#     scope currency.to_sym, -> {where("code = ? AND from_usd IS NOT NULL", currency)}
#   end

#   scope :last_year, -> {where('date >= ?', Date.today - 365.days).order('date ASC')}
#   class << self
#     def convert_to_usd(number = 0, currency, dates)
#       if currency.eql?('USD') || number.zero?
#         number
#       else
#         i = 1
#         dates[1] = dates[0] + 1.day if dates[1].eql?(dates[0])
#         average = Currency.send(currency).where('date BETWEEN ? AND ?', dates[0], dates[1]).average(:from_usd)
#         while average.nil?
#           average = Currency.send(currency).where('date BETWEEN ? AND ?', dates[0]-i.days, dates[1] + i.days).average(:from_usd)
#           i = i + 1
#         end

#         (number / average).round
#       end
#     end

#     def chart_data
#       ['gbp', 'eur', 'btc'].each do |currency|
#         currencies = Currency.send(currency.upcase).last_year
#         data = currencies.map{|i| (1 / i.from_usd).round(3)}
#         labels = currencies.collect{|i| i.date.strftime('%b')}
#         instance_variable_set("@#{currency}", {data: data, labels: labels})
#       end

#       return {gbp: @gbp, eur: @eur, btc: @btc}
#     end
#   end
# end
