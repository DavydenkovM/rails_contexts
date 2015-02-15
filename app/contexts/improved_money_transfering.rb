class ImprovedMoneyTransfering
  include ActiveModel::Model
  extend Surrounded::Context

  delegate :display_error,
           :go_to,
           :new_transfers_path, to: :controller

  attr_accessor :amount

  initialize(:source, :destination, :controller)

  validates :amount, presence: true,
                     numericality: { only_integer: true, greater_than: 10 }

  def initialize(source = nil, destination = nil, controller = nil, amount = nil)
    return self unless source && destination

    map_roles([[:source, :source],
               [:destination, :destination]])
    self.amount = amount
  end

  trigger :perform do
    # if valid?
      transfer_money
    # end

    errors.messages.any? ? (display_error :new) : (go_to new_improved_transfers_path)
  end

  def transfer_money
    source.transfer_to(destination, amount.to_i,
                         failure: ->(attribute, message) { errors.add(attribute, message) })
  end
end
