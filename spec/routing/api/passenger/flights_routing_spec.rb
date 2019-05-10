require "rails_helper"

RSpec.describe Api::Passenger::FlightsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/passenger/flights").to route_to("api/passenger/flights#index")
    end

    it "routes to #new" do
      expect(:get => "/api/passenger/flights/new").to route_to("api/passenger/flights#new")
    end

    it "routes to #show" do
      expect(:get => "/api/passenger/flights/1").to route_to("api/passenger/flights#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/passenger/flights/1/edit").to route_to("api/passenger/flights#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/passenger/flights").to route_to("api/passenger/flights#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/passenger/flights/1").to route_to("api/passenger/flights#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/passenger/flights/1").to route_to("api/passenger/flights#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/passenger/flights/1").to route_to("api/passenger/flights#destroy", :id => "1")
    end
  end
end
