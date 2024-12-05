module Users
  class AccountController < ApplicationController
    before_action :authenticate_user!

    def create
      @account = current_user.accounts.create(account_params)
      if @account.save
        flash[:notice] = "Account added successfully"
        redirect_to dashboard_path
      else
        redirect_to dashboard_path, alert: "Account was not created. Please try again."
      end
    end

    private

    def account_params
      params.permit(:name, :balance, :account_type, :currency)
    end
  end
end