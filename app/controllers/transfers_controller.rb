class TransfersController < ApplicationController
  before_action :authenticate_user!

  def new
    @transfer = MoneyTransfering.new(self)
  end

  def create
    @transfer = MoneyTransfering.new(self, transfers_params)
    @transfer.perform
  end

  private

  def transfers_params
    params.require(:money_transfering)
          .permit(:source_id, :destination_id, :amount)
  end
end
