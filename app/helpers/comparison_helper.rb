module ComparisonHelper

  # def funding_date(funding)
  #   date = "#{funding['funded_year']}"
  #   date += "-#{funding['funded_month']}" if funding['funded_month']
  #   date += "-#{funding['funded_day']}" if funding['funded_day']
  #   date
  # end

  # def investors(funding)
  #   content_tag(:ol) do
  #     funding['investments'].each do |investment|
  #         if investment['company']
  #           data = investment['company']['name']
  #         elsif investment['financial_org']
  #           data = investment['financial_org']['name']
  #         elsif investment['person']
  #           data = investment['person']['first_name'] + investment['person']['last_name']
  #         else
  #           data = ''
  #         end
  #       concat content_tag(:li, data)
  #     end
  #   end 
  # end

  # def total_funding(funding_rounds)
  #   funding_rounds.collect{|item| item['raised_amount'].to_f}.inject(:+) / 1000000.0
  # end
end
