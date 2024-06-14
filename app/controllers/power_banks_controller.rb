class PowerBanksController < ApplicationController
  before_action :set_power_bank, only: [:show, :update, :destroy]

  def index
    @power_banks = PowerBank.all
    render json: @power_banks
  end

  def show
    render json: @power_bank
  end

  def create
    @power_bank = PowerBank.new(power_bank_params)
    if @power_bank.save
      render json: @power_bank, status: :created
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end

  def update
    if @power_bank.update(power_bank_params)
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @power_bank.destroy
    head :no_content
  end

  private

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

  def power_bank_params
    params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
  end
end
