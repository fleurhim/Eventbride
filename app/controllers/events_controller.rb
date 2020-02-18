class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

  def index
  	@events = Event.all
  end

  def new
  	@event = Event.new
  end

  def create
  	@event = Event.new(
  		start_date: params[:start_date], 
  		user_id: current_user.id,
  		duration: params[:duration],
  		title: params[:title],
  		description: params[:description],
  		price: params[:price],
  		location: params[:location]
  		)

  	if @event.save
  		redirect_to event_path(@event.id)
  	else
  		redirect_to new_event_path
  	end
  end

  def show
  	@event = Event.find(params[:id])
  	@end_date = Event.end_date(Event.find(params[:id]))
  end

end
