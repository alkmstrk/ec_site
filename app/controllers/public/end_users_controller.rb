class Public::EndUsersController < ApplicationController

  def update
    if current_end_user.update(end_user_params)
      redirect_to end_users_my_page_path
    else
      render :edit
    end
  end

  def is_deleted
    current_end_user.update(is_deleted: true)
    reset_session
  end

  private
  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email)
  end
end



