class ImprovedMoneyTransfering
  module Source
    def transfer(amount, callbacks = nil)
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
