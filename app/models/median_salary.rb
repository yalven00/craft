# class MedianSalary < ActiveRecord::Base

#   STATES = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 
#         'FL', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 
#         'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 
#         'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 
#         'OH', 'OK', 'OR', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 
#         'TX', 'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY']

#   def self.find_titles(query)
#     self.select(:title).where("LOWER (title) LIKE ?", "%#{query.downcase}%").pluck(:title)
#   end

#   def self.search(params)
#     self.where('title = ? AND location IN (?)', params[:title], params[:states])
#   end
# end
