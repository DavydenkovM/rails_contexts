class MoneyTransfering
  include ActiveModel::Model

  attr_reader :amount, :destination_id, :source_id,
              :controller, :destination, :source

  delegate :display_error,
           :go_to,
           :new_transfers_path, to: :controller

  validates :amount, presence: true,
                     numericality: { only_integer: true, greater_than: 10 }

  def initialize(controller, params = {})
    return self if params.empty?

    @source = find_account(params[:source_id])
    @destination = find_account(params[:destination_id])

    assign_transferrer(@source)
    assign_recipient(@destination)
    @controller = controller

    set_context_params(params)
  end

  def perform
    ActiveRecord::Base.transaction do
      if valid?
        source.transfer_to(destination, amount.to_i, failure: default_fallback) and
        destination.increment_bonus_points(amount.to_i, failure: default_fallback)
      end
    end

    errors.messages.any? ? (display_error :new)
                         : (go_to new_transfers_path)
  end

  private

  def assign_transferrer(source)
    source.extend(MoneyTransfering::Transferrer)
  end

  def assign_recipient(destination)
    destination.extend(MoneyTransfering::Recipient)
  end

  def set_context_params(params)
    @amount = params[:amount]
    @source_id = params[:source_id]
    @destination_id = params[:destination_id]
  end

  def find_account(id)
    Account.find(id)
  end

  def default_fallback
    ->(attribute, message) { errors.add(attribute, message) }
  end
end
