require 'rails_helper'

describe Spot do
  before(:each) do
    @spot = build(:spot)
  end

  it "is valid with a name, adresse and user" do
    expect(@spot).to be_valid
  end

  it "is invalid without name" do
    @spot.nom = nil
    @spot.valid?
    expect(@spot.errors[:nom]).to include("can't be blank")
  end

  it "is invalid without adresse" do
    @spot.adresse = nil
    @spot.valid?
    expect(@spot.errors[:adresse]).to include("can't be blank")
  end

  context "when a post is geocoded" do
    it "return a spot with latitude and longitude" do
      @spot.geocode
      expect(@spot.latitude).to eq 47.3137604
      expect(@spot.longitude).to eq 2.2552803
    end
  end

  context "a post is forecasted" do
    it "return a hash" do
      saved_spot = create(:spot)
      expect(saved_spot.instance_eval { forecast_request }.is_a? Hash).to eq true
    end

    it "return wind speed on a spot" do
      @spot.geocode
      @spot.set_windspeed
      expect(@spot.vitesse.class).to eq Float
    end
  end
end