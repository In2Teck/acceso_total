class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :uid, :first_name, :last_name, :roles

  has_and_belongs_to_many :roles
  has_many :invites
  has_many :participations

  validates_presence_of :email#, :password

  validates_format_of :email, :with => Devise.email_regexp

	def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
		user = User.where(:email => auth.info.email).first
		if not user
			# CHECK FOR NEW/CREATE
			user = User.create(first_name:auth.info.first_name, last_name:auth.info.last_name, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20])
    # se actualiza si uno participo primero con  correo y luego por facebook
    elsif user.first_name == nil
      user.update_attributes(:first_name => auth.info.first_name, :last_name => auth.info.last_name, :uid => auth.uid, :password => Devise.friendly_token[0,20], :roles => [])
		end
		user
	end

  def self.find_or_create_user email
    user = User.find_by_email(email)
    if not user
      user = User.create(email: email, :roles => [])
    end
    user
  end

	def role?(role)
		return !!self.roles.find_by_name(role)
	end

  def password_required?
    false
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

end
