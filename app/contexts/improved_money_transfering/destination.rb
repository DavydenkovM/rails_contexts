class MoneyTransfering
  module Destination
    role :destination do
      def foo
        'bar'
      end
    end
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


