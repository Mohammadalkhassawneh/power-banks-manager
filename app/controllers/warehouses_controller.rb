class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :update, :destroy]

  def index
    @warehouses = Warehouse.all
    render json: @warehouses
  end

  def show
    render json: @warehouse
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      render json: @warehouse, status: :created
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  def update
    if @warehouse.update(warehouse_params)
      render json: @warehouse
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @warehouse.destroy
    head :no_content
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name)
  end
end
