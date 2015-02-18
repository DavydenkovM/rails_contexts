class MoneyTransfering
  include ActiveModel::Model

  attr_reader :amount, :destination_id, :source_id,
              :controller, :destination, :source, :transfering_system

  delegate :display_error,
           :go_to,
           :new_transfers_path, to: :controller

  validates :amount, presence: true,
                     numericality: { only_integer: true, greater_than: 10 }

  def initialize(controller, params = {})
    return self if params.empty?

    @source = find_account(params[:source_id])
    @destination = find_account(params[:destination_id])
    @transfering_system = ::TransferingSystem.new

    assign_source(@source)
    assign_destination(@destination)
    assign_transfering_system(@transfering_system)
    @controller = controller

    set_context_params(params)
  end

  def perform
    if valid?
      source.transfer(destination, amount.to_i, failure: default_fallback) and
      destination.increment_bonus_points(amount.to_i, failure: default_fallback) and
      transfering_system.save_transaction(source, destination, failure: default_fallback)
    end

    errors.messages.any? ? (display_error :new)
                         : (go_to new_transfers_path)
  end

  private

  def assign_source(source)
    source.extend(MoneyTransfering::Source)
  end

  def assign_destination(destination)
    destination.extend(MoneyTransfering::Destination)
  end

  def assign_transfering_system(transfering_system)
    transfering_system.extend(MoneyTransfering::System)
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
