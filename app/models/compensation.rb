class Compensation < ActiveRecord::Base
  belongs_to :user
  scope :full_time, -> {where(position_type: 'full_time')}
  scope :consulting, -> {where(position_type: 'consulting')}

  before_save :set_percent_of_target, if: :is_full_time?

  # -------- CLASS METHODS --------

  class << self
    def chart_data
      # for consulting pay comparison by client
      chart = {}
      chart = confulting_pay_compirison_by_client(chart, self)

      # for salary progression
      chart = salary_progression(chart, self)

      # for full-time compensations chart
      chart = full_time_comparison(chart, self)

      # for consulting total cash chart
      chart = consulting_total_cash(chart, self)
      return chart
    end

    def confulting_pay_compirison_by_client(chart, compensations)
      consulting = compensations.consulting

      labels = consulting.map(&:company)
      data = consulting.collect{|i| i.day_rate}
      
      chart.merge!({consulting: {labels: labels, data: data}})
    end

    def salary_progression(chart, compensations)
      full_time = compensations.full_time

      start_year = full_time.order(:start_date).first.start_date.year
      labels = (start_year..Date.today.year).to_a

      comps = labels.collect do |i|
        full_time.where("start_date <= ? AND end_date >= ? OR start_date >= ? and start_date <= ?", Date.new(i, 1, 1), Date.new(i, 1, 1), Date.new(i, 1, 1), Date.new(i, 12, 31)).sum(:total).round(2)
      end

      progression = []
      comps.each_with_index do |value, index| 
        item = index.zero? ? 0 : ((value / comps[index-1]) - 1).round(2) # do not compare first and last elements 
        progression << item
      end

      chart.merge!({salary: {labels: labels, data: [comps, progression]}})
      chart
    end

    def full_time_comparison(chart, compensations)
      full_time = compensations.full_time
      labels = full_time.map(&:company)
      actual_paids = []
      base_salaries = []

      full_time.each do |i|
        currency = i.currency
        dates = [i.start_date, i.end_date]
        base_salaries << Currency.convert_to_usd(i.base_salary, currency, dates)
        actual_paids << Currency.convert_to_usd(i.actual_paid, currency, dates)
      end

      data = [{name: 'Bonus', data: actual_paids }, {name: 'Base Salary', data: base_salaries }]
      chart.merge!({full_time: {labels: labels, compensations: data.to_json}})
    end

    def consulting_total_cash(chart, compensations)
      consulting = compensations.consulting
      labels = consulting.map(&:company)
      data = consulting.collect{|c| Currency.convert_to_usd(c.total, c.currency, [c.start_date, c.end_date || Date.today])}
      chart.merge!({consulting_total_cash: {data: data, labels: labels}})
    end
  end

  # -------- CLASS METHODS --------

  def is_full_time?
    self.position_type == 'full_time'
  end

  def set_percent_of_target
    self.percent_of_target = (self.actual_paid.to_f / self.target.to_f) * 100.0
  end

  def day_rate
    if self.rate_type == 'Full Project'
      d_rate = self.rate / self.duration
    else
      rates = {'Hour' => 8, 'Day' => 1, 'Week' => 1 / 7.0, 'Month' => 1 / 30.0}
      d_rate = self.rate * rates[self.rate_type.capitalize] 
    end
    d_rate.round(2)
  end

  def duration
    end_date = self.end_date || Date.today
    (end_date - self.start_date).to_i
  end
end
