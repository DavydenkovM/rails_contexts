class ImprovedTransfersController < ApplicationController
  before_action :authenticate_user!

  def new
    @transfer = ImprovedMoneyTransfering.new
  end

  def create
    @transfer = ImprovedMoneyTransfering.new(
                  Account.find_by(id: improved_transfers_params[:source_id]), 
                  Account.find_by(id: improved_transfers_params[:destination_id]),
                  improved_transfers_params[:amount],
                  self)
    @transfer.perform
  end

  private

  def improved_transfers_params
    params.require(:improved_money_transfering)
          .permit(:source_id, :destination_id, :amount)
  end

  def amount
    improved_transfers_params[:amount]
  end
end
