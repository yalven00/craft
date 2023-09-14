class Authentication < ActiveRecord::Base
  belongs_to :user

  def authorize_user
    client = LinkedIn::Client.new(ENV['LINKEDIN_APP_ID'], ENV['LINKEDIN_APP_SECRET'])
    client.authorize_from_access(self.token, self.secret)
    client
  end
end
