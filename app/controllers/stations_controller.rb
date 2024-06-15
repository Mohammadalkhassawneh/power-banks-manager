class StationsController < ApplicationController
  before_action :set_station, only: [:show, :update, :destroy]

  def index
    @stations = Station.all
    render json: @stations
  end

  def show
    render json: @station
  end

  def create
    @station = Station.new(station_params)
    authorize @station
    if @station.save
      render json: @station, status: :created
    else
      render json: @station.errors, status: :unprocessable_entity
    end
  end

  def update
    if @station.update(station_params)
      render json: @station
    else
      render json: @station.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @station.destroy
    head :no_content
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end
end
