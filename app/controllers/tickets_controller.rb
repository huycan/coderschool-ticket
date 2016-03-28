class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    if !@event.is_upcoming?
      flash[:error] = 'This event already happened!'
      redirect_to(root_path) and return
    end
  end
end
