class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :icon, ImageUploader
  validates_processing_of :icon
  validate :image_size_validation

  attr_accessor :login
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9]*\z/}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: %i[facebook]

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
    else
      where(conditions.to_hash).first
    end
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.icon = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  def self.from_facebook(auth)
    where(facebook_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def self.from_twitter(auth)
    where(twitter_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end


  def self.from_linkedin(auth)
    where(linkedin_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def feed
    posts
  end

  private

    def image_size_validation
      errors[:icon] << "should be less than 500KB" if image.size > 0.5.megabytes
    end

end
