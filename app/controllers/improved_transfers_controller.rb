class ImprovedTransfersController < ApplicationController
  include Surrounded
  include Casting::Client
  delegate_missing_methods

  before_action :authenticate_user!

  def new
    @transfer = ImprovedMoneyTransfering.new
  end

  def create
    @transfer = ImprovedMoneyTransfering.new(
                  find_account(improved_transfers_params[:source_id]),
                  find_account(improved_transfers_params[:destination_id]),
                  self,
                  improved_transfers_params[:amount])
    @transfer.perform
  end

  private

  def find_account(id)
    Account.find_by(id: id)
  end

  def improved_transfers_params
    params.require(:improved_money_transfering)
          .permit(:source_id, :destination_id, :amount)
  end

  def amount
    improved_transfers_params[:amount]
  end
end
