class Public::AddressesController < ApplicationController
  before_action :set_address, only:[:edit, :update, :destroy]

  def index
    @address = Address.new
  end

  def create
    @address = current_end_user.addresses.new(address_params)
    @address.save
    redirect_to addresses_path
  end

  def update
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end

  def set_address
    @address = Address.find(params[:id])
  end

end
