# # encoding: UTF-8
# class MarketSalary < ActiveRecord::Base
#   def self.parse(csv)
#     CSV.foreach(csv) do |row|
#       if row[17] == 'Certified'
#         submitted_date = row[0].present? ? DateTime.strptime(row[0], '%m/%d/%Y %H:%M:%s') : ''
#         start_date = row[10].present? ? DateTime.strptime(row[10], '%m/%d/%Y %H:%M:%s') : ''
#         end_date = row[11].present? ? DateTime.strptime(row[11], '%m/%d/%Y %H:%M:%s') : ''
#         certified_begin_date = row[14].present? ? DateTime.strptime(row[14], '%m/%d/%Y %H:%M:%s') : ''
#         certified_end_date = row[15].present? ? DateTime.strptime(row[15], '%m/%d/%Y %H:%M:%s') : ''
#         part_time = row[21] == 'Y'
#         employer_address = "#{row[4]}, #{row[5]}"
#         dol_decision_date = row[13].present? ? DateTime.strptime(row[13], '%m/%d/%Y %H:%M:%s') : ''
#         params = {
#           submitted_date: submitted_date, start_date: start_date, end_date: end_date, certified_begin_date: certified_begin_date, certified_end_date: certified_end_date, 
#           part_time: part_time, case_number: row[1], program_designation: 'H1B', employer_name: row[3], employer_city: row[6], 
#           employer_address: employer_address, employer_state: row[7], employer_postal_code: row[8], nbr_immigrants: row[9], 
#           job_title: row[12], dol_decision_date: dol_decision_date, occupation_code: row[16], approval_status: row[17], 
#           wage_rate_from: row[18], wage_rate_per: row[19], wage_rate_to: row[20], work_city: row[22], work_state: row[23], prevailing_wage: row[24] 
#         }
#         self.create(params)
#       end
#     end
#   end

#   def self.search(params)
#     result = self.all
#     if params['title'].present?
#       result = result.where('job_title = ?', params['title'])
#     end

#     if params['company'].present?
#       result = result.where('employer_name = ?', params['company'])
#     end

#     return result
#   end

#   def self.autocomplete(query, field)
#     self.where("LOWER (#{field}) LIKE ?", "%#{query.downcase}%").pluck(field).uniq!
#   end
# end
