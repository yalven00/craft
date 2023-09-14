# class Occupation < ActiveRecord::Base

#   def self.find_occupation(query)
#     self.where('LOWER (title) LIKE ?', "%#{query.downcase}%").collect{|i| i.title}.uniq!
#   end

#   def self.find_area(query)
#     self.select(:area).where("LOWER (area) LIKE ?", "%#{query.downcase}%").uniq!.collect{|i| i.area}
#   end

#   def self.search(params)
#     occupations = self.where('title = ? AND area = ?', params[:title], params[:area])

#     employment = EmploymentProjection.find_by_code(occupations.first.code).employment_data.to_json
#     jobs = EmploymentProjection.find_by_code(occupations.first.code).jobs_data.to_json
#     salary_range = occupations.collect{|item|{name: "Salary", data: item.percent_annual.gsub(',', '').split(';').collect{|i| i.to_i} }}.to_json

#     return {
#           employment: employment, jobs: jobs, occupation: params[:occupation], 
#           education: 'Education', salary_range: salary_range
#         }
#   end
# end
