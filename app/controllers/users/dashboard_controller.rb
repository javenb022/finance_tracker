module Users
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def show
      @user = current_user
      @accounts = @user.accounts
    end
  end
end