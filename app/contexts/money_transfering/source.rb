class MoneyTransfering
  module Source
    def transfer(destination, amount, callbacks = nil, any_errors = false)
      self.balance -= amount
      destination.balance += amount

      unless valid?
        yield_errors(self, callbacks)
      end

      unless destination.valid?
        yield_errors(destination, callbacks)
      end

      if any_errors
        false
      else
        TransferPrinting.new(self).print
        true
      end
    end

    private

    def yield_errors(model, callbacks)
      return unless callbacks

      model.errors.messages.each do |attribute, message|
        callbacks[:failure].call(attribute, message[0])
      end
    end
  end
end

