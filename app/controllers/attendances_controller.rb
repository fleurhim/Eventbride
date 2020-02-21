class AttendancesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def new
		if 
		@attendance = Attendance.new
		@event = Event.find(params[:event_id])
		@user = current_user
	end

	def index
		@attendances = Event.find(params[:event_id]).attendances
		@event = Event.find(params[:event_id])
	end

	def create

	  @event = Event.find(params[:event_id])

	  @amount = @event.price*100

	  customer = Stripe::Customer.create({
	    email: params[:stripeEmail],
	    source: params[:stripeToken],
	  })

	  charge = Stripe::Charge.create({
	    customer: customer.id,
	    amount: @amount,
	    description: 'Rails Stripe customer',
	    currency: 'eur',
	  })

	  @attendance = Attendance.new(user_id: current_user.id.to_i, event_id: @event.id.to_i, stripe_customer_id: customer.id.to_i)

	  if @attendance.save
			flash[:success] = "Paiement accepté ! Vous êtes maintenant inscrit à l'évènement"
			redirect_to event_path(@event.id)
		else
			redirect_to new_event_attendance_path(@event.id)
			flash[:error] = "Le paiement a échoué"
		end

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_event_charge_path
	end

	end
end
