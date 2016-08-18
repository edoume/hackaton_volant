class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy, :refresh]

  def index
    @spots = current_user.spots
  end

  def show
    @tabvitesse = @spot.tableauvitesse
    @tabheure = @spot.tableauheure
    @htime = @spot.htime
    @dday = @spot.dday
    @pluietab = @spot.tabpluie
  end

  def new
    @spot = Spot.new
  end

  def edit
  end

  def create
    @spot = current_user.spots.new(spot_params)

    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: 'Votre Spot a bien été créé.' }
        format.json { render :show, status: :created, location: @spot }
      else
        format.html { render :new }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to @spot, notice: 'Votre Spot a bien été édité.' }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_url, notice: 'Votre Spot a bien été supprimé.' }
      format.json { head :no_content }
    end
  end

  def refresh
    @spot.set_windspeed
    redirect_to root_path
  end

  private

    def set_spot
      @spot = Spot.find(params[:id])
    end

    def spot_params
      params.require(:spot).permit(:nom, :adresse)
    end
end
