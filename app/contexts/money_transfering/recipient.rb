class MoneyTransfering
  module Recipient
    def increment_bonus_points(points, callbacks = {failure: ->{} })
      self.bonus_points += points
      save!
    rescue
      yield_errors(self, callbacks)
      false
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
