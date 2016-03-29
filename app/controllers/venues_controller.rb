class VenuesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @venue = Venue.new venue_params
    
    if @venue.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def venue_params
    params.require(:venue).permit :name, :address, :region_id
  end
end
