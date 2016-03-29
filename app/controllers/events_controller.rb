class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

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
