class MoneyTransfering
  module Transferrer
    extend ActiveSupport::Concern

    def transfer_to(destination, amount, callbacks = nil)
      self.balance -= amount
      destination.balance += amount
      save!
      destination.save!
    rescue
      yield_errors(destination, callbacks)
      false
    else
      TransferPrinting.new(self).print
      true
    end

    private

    def yield_errors(destination, callbacks)
      return unless callbacks

      errors.messages.each do |attribute, message|
        callbacks[:failure].call(attribute, message[0])
      end

      destination.errors.messages.each do |attribute, message|
        callbacks[:failure].call(attribute, message[0])
      end
    end
  end
end
