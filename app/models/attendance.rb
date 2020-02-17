class Attendance < ApplicationRecord
	after_create :validation_send

  belongs_to :event
  belongs_to :user

 	def validation_send
  	UserMailer.validation_email(self.event, self.user).deliver_now
  end
end
