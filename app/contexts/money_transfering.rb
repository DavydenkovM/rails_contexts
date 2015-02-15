class MoneyTransfering
  include ActiveModel::Model

  attr_accessor :amount,
                :controller,
                :destination_id,
                :params,
                :source_id

  attr_reader :destination,
              :source

  delegate :display_error,
           :go_to,
           :new_transfers_path, to: :controller

  validates :amount, presence: true,
                     numericality: { only_integer: true, greater_than: 10 }

  def initialize(params = {}, controller = nil)
    return self if params.empty?

    set_context_params(params)
    @source = find_account(params[:source_id])
    @destination = find_account(params[:destination_id])

    assign_transferrer(@source)
    assign_recipient(@destination)
    @controller = controller
  end

  def perform
    if valid?
      source.transfer_to(destination, amount.to_i,
                         failure: ->(attribute, message) { errors.add(attribute, message) })
    end

    errors.messages.any? ? (display_error :new) : (go_to new_transfers_path)
  end

  private

  def assign_transferrer(source)
    source.extend(MoneyTransfering::Transferrer)
  end

  def assign_recipient(destination)
    destination.extend(MoneyTransfering::Recipient)
  end

  def set_context_params(params)
    self.params = params
    self.amount = params[:amount]
    self.source_id = params[:source_id]
    self.destination_id = params[:destination_id]
  end

  def find_account(id)
    Account.find(id)
  end
end

