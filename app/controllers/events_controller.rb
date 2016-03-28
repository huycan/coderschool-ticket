class EventsController < ApplicationController
  def index
    @events = Event.upcoming

    if params[:search].present?
      @events = @events.search params[:search]  
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
