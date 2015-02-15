class MoneyTransfering
  module Recipient
    extend ActiveSupport::Concern

    # def transfer_to(destination, amount, callbacks = nil)
    #   transaction do
    #     begin
    #       self.balance -= amount
    #       destination.balance += amount
    #       save
    #       destination.save
    #       # callbacks[:success].call
    #     rescue
    #       # callbacks[:failure].call
    #     end
    #   end
    # end
  end
end
