module Refinery
  module AuthenticatedSystem
    # Store the URI of the current request in the session.
    #
    # We can return to this location by calling #redirect_back_or_default.
    def store_location
      session[:return_to] = request.fullpath
    end
    
    # Clear and return the stored location
    def pop_stored_location
      session.delete(:return_to)
    end

    # Redirect to the URI stored by the most recent store_location call or
    # to the passed default.
    def redirect_back_or_default(default)
      redirect_to(pop_stored_location || default)
    end

    # This just defines the devise method for after sign in to support
    # extension namespace isolation...
    def after_sign_in_path_for(resource_or_scope)
      main_app.root_path
    end

    def after_sign_out_path_for(resource_or_scope)
      main_app.root_path
    end

    def refinery_user?
      refinery_user_signed_in? && current_refinery_user.has_role?(:refinery)
    end

    ### PATCH FOR SPREE AUTH *and* REFINERY AUTH
    def current_refinery_user
      current_spree_user
    end

    def refinery_user_signed_in?
      spree_user_signed_in?
    end

    def authenticate_refinery_user!
      authenticate_spree_user!
    end
    ### END of Spree + Refinery patch
                                 
    protected :store_location, :pop_stored_location, :redirect_back_or_default, :refinery_user?

    def self.included(base)    
      if base.respond_to? :helper_method
        base.send :helper_method, :current_refinery_user, :current_user_session,
        :refinery_user_signed_in?, :refinery_user?
      end
    end
  end
end