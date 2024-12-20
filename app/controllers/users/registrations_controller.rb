# frozen_string_literal: true

# This file is used to define the RegistrationsController class, which is used to handle user registration actions.
module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params
    before_action :configure_account_update_params

    def show
      if current_user
        @user = User.find(current_user.id)
      else
        redirect_to root_path
        flash[:error] = "You must be logged in to visit that page."
      end
    end

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :address, :zip_code, :city, :state, :date_of_birth])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :address, :zip_code, :city, :state, :date_of_birth])
    end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
      dashboard_path
    end

    def after_update_path_for(resource)
      profile_path
    end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
