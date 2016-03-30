class TicketTypesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find params[:event_id]
    @ticket_type = TicketType.new ticket_type_params
    
    if @ticket_type.valid?
      @event.ticket_types << @ticket_type
      redirect_to root_path
    else
      render 'events/edit'
    end
  end
 
  private
    def ticket_type_params
      params.require(:ticket_type).permit :name, :price, :max_quantity
    end
end
