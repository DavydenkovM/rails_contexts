class TransfersController < ApplicationController
  before_action :authenticate_user!

  def new
    @transfer = MoneyTransfering.new
  end

  def create
    @transfer = MoneyTransfering.new(transfers_params, self)
    @transfer.perform
  end

  private

  def transfers_params
    params.require(:money_transfering)
          .permit(:source_id, :destination_id, :amount)
  end

  def amount
    transfers_params[:amount]
  end
end
