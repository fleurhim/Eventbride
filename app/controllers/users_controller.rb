class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show]
	before_action :is_the_owner_of_the_page?, only: [:show]

	def show
		@user = User.find(params[:id])
		@events = Event.where(user_id: params[:id])
	end

	private

  	def is_the_owner_of_the_page?
  		unless current_user.id.to_i == params[:id].to_i
  		redirect_to events_path
  		end
  	end
end
