require 'rails_helper'

RSpec.describe "routing", :type => :routing do
  it "routes /events to events#index" do
    expect(:get => "/events").to route_to(
      :controller => "events",
      :action => "index"
    )
  end

  it "does not show all users" do
    expect(:get => "/users").not_to be_routable
  end
end