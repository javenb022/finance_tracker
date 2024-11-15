module Users
  class TransactionController < ApplicationController
    before_action :authenticate_user!
    def create
      @transaction = current_user.transactions.create(transaction_params)
      
      @transaction.set_default_category

      if @transaction.save
        current_user.accounts.find(@transaction.account_id).update_balance(@transaction)
        redirect_to request.referrer, notice: "Transaction was successfully created."
      else
        redirect_to dashboard_path, alert: "Transaction was not created. Please try again."
      end
    end

    private
    def transaction_params
      params[:transaction_date] = Date.strptime(params[:transaction_date], "%m/%d/%Y")
      params.permit(:user_id, :account_id, :category_id, :amount, :transaction_date, :description, :transaction_type)
    end
  end
end