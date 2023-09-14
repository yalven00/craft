class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:linkedin]

  has_many :authentications, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :desired_jobs, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :projects, through: :positions
  has_many :educations, dependent: :destroy
  has_many :assets
  has_many :compensations, dependent: :destroy
  has_many :user_lists, dependent: :destroy
  has_many :user_list_line_items, through: :user_lists

  after_create :create_default_user_list

  validates_length_of :password, minimum: 6 unless :new_record?

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # LinkedIn feature

  def connect_to_linkedin(auth)
    self.disconnect_from_linkedin!
    params = {
      provider: auth.provider, 
      uid: auth.uid, 
      token: auth["extra"]["access_token"].token,
      secret: auth["extra"]["access_token"].secret
    }
    authentication = self.authentications.build(params)
    if authentication.save!
      # self.import_data_from_linkedin!
      true
    else
      false
    end
  end

  def disconnect_from_linkedin!
    if authentication = self.authentications.find_by_provider('linkedin')
      authentication.destroy
    end
  end

  def linkedin_authentication
    self.authentications.find_by_provider('linkedin')
  end

  def self.create_from_linkedin(auth)
    user = self.new
    authentication = user.authentications.build(token: auth["extra"]["access_token"].token, secret: auth["extra"]["access_token"].secret)
    profile = authentication.authorize_user.profile(fields: ['email-address'])
    if u = User.find_by_email(profile['email-address'])
      user = u
    else
      user.email = profile['email-address']
      user.password = 'dumpy-password'
      user.skip_confirmation!
      user.save!
    end
    user
  end

  def import_data_from_linkedin!
    client = self.linkedin_authentication.authorize_user
    profile = client.profile(fields: ['first-name', 'last-name', 'location', 'date-of-birth', 'positions', 'educations'])
    get_personal_info(profile)
    create_positions(profile) if profile.positions.any?
    create_educations(profile) if profile.educations.any?
    self.save!
  end

  def get_personal_info(profile)
    date = profile.date_of_birth
    self.birth_date = Date.from_hash(date) if date.present?
    self.first_name = profile.first_name
    self.last_name = profile.last_name
    self.country = profile.location.name
  end

  # TODO: merge to one method
  def create_positions(profile)
    profile.positions.all.each do |p|
      position = self.positions.find_or_initialize_by(pid: p.id)
      position.update_fields!(p)
    end
  end

  def create_educations(profile)
    profile.educations.all.each do |e|
      position = self.educations.find_or_initialize_by(eid: e.id)
      position.update_fields!(e)
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def create_default_user_list
    self.user_lists.build(name: 'My List').save!
  end
end
