class ImprovedTransfersController < ApplicationController
  include Awareness

  before_action :authenticate_user!

  def new
    @transfer = ImprovedMoneyTransfering.new(self)
  end

  def create
    @transfer = ImprovedMoneyTransfering.new(self, improved_transfers_params)
    @transfer.perform
  end

  private

  def improved_transfers_params
    params.require(:improved_money_transfering)
          .permit(:source_id, :destination_id, :amount)
  end
end
