class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_event, only: [:show, :edit, :publish, :update]

  def index
    @events = Event.viewable(!!current_user ? current_user.id : nil).upcoming

    if params[:search].present?
      @events = @events.search params[:search]  
    end
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @event.user = current_user
    
    if @event.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @event.update event_params
    redirect_to root_path
  end

  def publish
    if @event.publishable?
      @event.publish!
      @event.save
    end

    redirect_to root_path
  end

  private
  def event_params
    params.require(:event).permit :name, :category_id, :venue_id, :starts_at, :ends_at, :hero_image_url, :extended_html_description
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
