module Users
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def show
      @user = current_user
      @accounts = @user.accounts
      @grouped_checking_transactions = @user.grouped_checking_transactions
      @grouped_savings_transactions = @user.grouped_savings_transactions
      @grouped_credit_card_transactions = @user.grouped_credit_card_transactions
      @recent_transactions = @user.recent_transactions
      @monthly_income = @user.monthly_income
      @monthly_expenses = @user.monthly_expenses
      @expenses_by_category = @user.expenses_by_category
    end
  end
end
