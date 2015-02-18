class ImprovedMoneyTransfering
  module System
    def save_transaction(callbacks = nil)
      ActiveRecord::Base.transaction do
        begin
          source.save!
          destination.save!
        rescue
          yield_errors(source, callbacks)
          yield_errors(destination, callbacks)
          false
        end
      end
    end

    def yield_errors(model, callbacks)
      return unless callbacks

      model.errors.messages.each do |attribute, message|
        callbacks[:failure].call(attribute, message[0])
      end
    end
  end
end
