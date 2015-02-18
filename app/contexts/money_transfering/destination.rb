class MoneyTransfering
  module Destination
    def increment_bonus_points(points, callbacks = nil)
      self.bonus_points += points

      if valid?
        true
      else
        yield_errors(self, callbacks)
        false
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

