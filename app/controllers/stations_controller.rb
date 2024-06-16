class StationsController < ApplicationController
  before_action :set_station, only: [:show, :update, :destroy]

  def index
    @stations = policy_scope(Station)
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

  def available_power_banks
    authorize @station, :available_power_banks?
    @available_power_banks = @station.power_banks.where(user_id: nil) # Assuming user_id is nil for available power banks
    render json: @available_power_banks
  end

  def take_power_bank
    authorize @station, :take_power_bank?
    @power_bank = @station.power_banks.find(params[:power_bank_id])
    @power_bank.update(user_id: current_user.id) # Assign power bank to current user
    render json: @power_bank
  end

  def return_power_bank
    authorize @station, :return_power_bank?
    @power_bank = @station.power_banks.find(params[:power_bank_id])
    @power_bank.update(user_id: nil) # Remove user assignment (returning the power bank)
    render json: @power_bank
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end
end
