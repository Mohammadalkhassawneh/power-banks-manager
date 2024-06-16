class PowerBanksController < ApplicationController
  before_action :set_power_bank, only: [:show, :update, :destroy, :assign_to_station, :assign_to_warehouse, :assign_to_user]

  def index
    @q = policy_scope(PowerBank).ransack(params[:q])
    @power_banks = @q.result.page(params[:page]).per(params[:per_page] || 10)
    render json: {
      power_banks: @power_banks,
      meta: {
        current_page: @power_banks.current_page,
        total_pages: @power_banks.total_pages,
        total_count: @power_banks.total_count
      }
    }
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

  def assign_to_station
    authorize @power_bank, :assign_to_station?

    @station = Station.find(params[:station_id])

    if @power_bank.update(station: @station)
      redirect_to @station, notice: 'Power bank was successfully assigned to station.'
    else
      flash[:alert] = @power_bank.errors.full_messages.join('. ')
      redirect_back(fallback_location: root_path)
    end
  end

  def assign_to_warehouse
    authorize @power_bank, :assign_to_warehouse?

    @warehouse = Warehouse.find(params[:warehouse_id])

    if @power_bank.update(warehouse: @warehouse)
      redirect_to @warehouse, notice: 'Power bank was successfully assigned to warehouse.'
    else
      flash[:alert] = @power_bank.errors.full_messages.join('. ')
      redirect_back(fallback_location: root_path)
    end
  end

  def assign_to_user
    authorize @power_bank, :assign_to_user?

    @user = User.find(params[:user_id])

    if @power_bank.update(user: @user)
      redirect_to @user, notice: 'Power bank was successfully assigned to user.'
    else
      flash[:alert] = @power_bank.errors.full_messages.join('. ')
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

  def power_bank_params
    params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
  end
end
