Refinery::AdminController.class_eval do
  def require_refinery_users!
    if current_spree_user && !current_spree_user.has_role?("Refinery")
      flash[:error] =  t(:authorization_failure)
      redirect_to spree.unauthorized_path
    elsif current_spree_user
      true
    else
      redirect_to spree.login_path
    end
  end

  def just_installed?
    Spree::Role[:refinery].users.empty?
  end
end
