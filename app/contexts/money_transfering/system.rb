class MoneyTransfering
  module System
    def save_transaction(source, destination, callbacks = nil)
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

    private

    def yield_errors(model, callbacks)
      return unless callbacks

      model.errors.messages.each do |attribute, message|
        callbacks[:failure].call(attribute, message[0])
      end
    end
  end
end
