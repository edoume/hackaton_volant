require 'rails_helper'

describe SpotsController do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  it "redirects to the home page upon save" do
    post :create, spot: FactoryGirl.attributes_for(:spot)
    expect(response).to redirect_to spot_path(Spot.last)
  end
end