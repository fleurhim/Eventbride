class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	after_create :welcome_send

	has_many :events
	has_many :attendances
	has_many :events, through: :attendances

	validates :email, presence: true, uniqueness: true

	def welcome_send
		UserMailer.welcome_email(self).deliver_now
	end

  	def is_already_attending?(event)
  		participants_id = event.attendances.pluck("user_id")
  		participants_id.include?(self.id.to_i) ? true : false
  	end

  	def is_already_admin?(event)
  		event.user.id.to_i == self.id.to_i ? true : false
  	end
end
