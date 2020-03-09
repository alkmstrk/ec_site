class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resourse)
    case resource
    when EndUser
      end_users_my_page_path
    when Admin
      admin_items_path
    end
  end

  def after_sign_out_path_for(resourse)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number ])
  end

  def tax
    @tax = 1.08
  end

  def shipping_cost
    @shipping_cost = 800
  end

end
