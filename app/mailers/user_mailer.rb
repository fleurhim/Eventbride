class UserMailer < ApplicationMailer
	default from: "no-reply@monsite.fr"

	def welcome_email(user)
		@user = user
		@url = 'https://pure-everglades-18951.herokuapp.com/'
		mail(to: @user.email, subject: 'Bienvenue chez nous !')
	end

	def validation_email(event, user)
		@event = event
		@user = user
		mail(to: @user.email, subject: 'Votre inscription est validée')
	end
end
