class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy, :refresh]

  # GET /spots
  # GET /spots.json
  def index
    @spots = current_user.spots
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
    @tabvitesse = @spot.tableauvitesse
    @tabheure = @spot.tableauheure
    @htime = @spot.htime
    @dday = @spot.dday
    @pluietab = @spot.tabpluie
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit
  end

  # POST /spots
  # POST /spots.json
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

  # PATCH/PUT /spots/1
  # PATCH/PUT /spots/1.json
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

  # DELETE /spots/1
  # DELETE /spots/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spot_params
      params.require(:spot).permit(:nom, :adresse)
    end
end
