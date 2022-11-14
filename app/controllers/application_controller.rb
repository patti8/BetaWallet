class ApplicationController < ActionController::Base
    
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :set_current_user

    private

        # def set_current_user
        #     User.current_user = current_user
        # end

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :national_id, :username])
        end

      

end
