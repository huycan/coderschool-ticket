class TicketsController < ApplicationController
  before_action :set_event, only: [:new, :create]

  def new
  end

  def create
    raise
    params[:ticket_type].each do |type_id, quantity|
      
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
    if !@event.is_upcoming?
      flash[:error] = 'This event already happened!'
      redirect_to(root_path) and return
    end
  end
end
