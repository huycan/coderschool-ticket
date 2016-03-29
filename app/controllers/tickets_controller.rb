class TicketsController < ApplicationController
  before_action :set_event, only: [:new, :create]

  def new
  end

  def create
    total = 0

    params[:ticket_type].each do |type_id, quantity|
      quantity = quantity.to_i
      ticket_type = TicketType.find type_id
      if !ticket_type.buyable?(quantity)
        flash.now[:error] = "The quantity for '#{ticket_type.name}' exceeds remaining available"
        redirect_to(new_event_ticket_path(params[:event_id])) and return
      elsif quantity > 0
        total += quantity
        ticket_type.tickets << Ticket.create(quantity: quantity)
      end
    end

    flash[:success] = "You bought #{total} tickets"
    
    redirect_to root_path
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
