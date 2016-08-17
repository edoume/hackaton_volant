require 'rails_helper'

describe SpotsController do
  before(:each) do
    @spot = create(:fixed_spot)
    @user = @spot.user
    sign_in @user
  end

  describe "GET #show" do
    it "assigns the requested spot to @spot" do
      get :show, id: @spot
      expect(assigns(:spot)).to eq @spot
    end

    it "render the :show template" do
      get :show, id: @spot
      expect(response).to render_template :show
    end
  end

  describe "GET #index" do
    context "with user's spot" do
      it "return array of spots" do
        spot2 = create(:fixed_spot, user: @user)
        get :index
        expect(assigns(:spots)).to match_array([@spot, spot2])
      end

      it "render the index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #new" do
    it "assigns a new Spot" do
      get :new
      expect(assigns(:spot)).to be_a_new(Spot)
    end

    it "render the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before(:each) do
      @spot2 = create(:fixed_spot, user: @user)
    end
    it "assigns a edit Spot" do
      get :edit, id: @spot2
      expect(assigns(:spot)).to eq @spot2
    end

    it "render the new template" do
      get :edit, id: @spot2
      expect(response).to render_template :edit
    end
  end

  describe "GET #create" do
    context "with valid attributes" do
      it "save the new spot" do
        expect{
          post :create, spot: FactoryGirl.attributes_for(:fixed_spot)}.to change(Spot, :count).by(1)
      end

      it "redirects to spot show" do
        post :create, spot: FactoryGirl.attributes_for(:fixed_spot)
        expect(response).to redirect_to spot_path(Spot.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new spot in the database" do
            expect{
              post :create,
                spot: attributes_for(:invalid_spot)
            }.not_to change(Spot, :count)
      end

      it "re-renders the :new template" do post :create,
              spot: attributes_for(:invalid_spot)
            expect(response).to render_template :new
      end
    end
  end
end