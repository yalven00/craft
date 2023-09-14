# class EmploymentProjection < ActiveRecord::Base

#   def employment_data
#     employment = self.employment.to_f
#     projection = self.projection.to_f
#     change = (projection - employment).round(1)
#     color = change > 0 ? '#8064a2' : 'red'

#     data = []
#     data << {name: 'Expected Change', data: [0, 0, 0]}
#     data << {name: '2010', data: [0, change, 0], color: color}
#     data << {name: '2020', data: [employment, employment, projection]}
#   end

#   def jobs_data
#     [{name: 'Jobs', data: [self.jobs.to_f]}]
#   end
# end
