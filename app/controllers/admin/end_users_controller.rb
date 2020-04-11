class Admin::EndUsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  
  def index
    @users = EndUser.all
  end

  def update
    @user.update(end_user_params) ? (redirect_to admin_end_user_path(@user)) : (render :edit)
    # if @user.update(end_user_params)
    #   redirect_to admin_end_user_path(@user)
    # else
    #   render :edit
    # end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email, :is_deleted)
  end

  def set_user
    @user = EndUser.find(params[:id])
  end
end
