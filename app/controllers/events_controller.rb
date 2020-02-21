class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
  before_action :is_admin?, only: [:update, :destroy, :edit]

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
  		location: params[:location], 
      picture: params[:picture]
  		)

  	if @event.save
      @event.picture.attach(params[:picture])
  		redirect_to event_path(@event.id)
  	else
  		redirect_to new_event_path, flash: { error: "Informations éronnées!" }
  	end
  end

  def show
  	@event = Event.find(params[:id])
  	@end_date = Event.end_date(Event.find(params[:id]))
  end

  def edit
    @event = @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(
      start_date: params[:start_date], 
      user_id: current_user.id,
      duration: params[:duration],
      title: params[:title],
      description: params[:description],
      price: params[:price],
      location: params[:location], 
      )
    redirect_to event_path(params[:id]), notice: "Well done! You successfully edited the event! "
    else
    render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :user_id, :duration, :title, :price, :description, :location, :picture)
  end

  def is_admin?
    @event = @event = Event.find(params[:id])
    @event.user.id.to_i == current_user.id.to_i ? true : false
  end

end
