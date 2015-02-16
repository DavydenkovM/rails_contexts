class ImprovedMoneyTransfering
  include ActiveModel::Model
  extend Surrounded::Context

  attr_reader :amount, :destination_id, :source_id,
              :controller, :source, :destination

  delegate :display_error,
           :go_to,
           :new_improved_transfers_path, to: :controller

  validates :amount, presence: true,
                     numericality: { only_integer: true, greater_than: 10 }

  def initialize(controller, params = {})
    return self if params.empty?

    map_roles([[:source, find_account(params[:source_id])],
               [:destination, find_account(params[:destination_id])],
               [:controller, controller]])

    set_context_params(params)
    super()
  end

  trigger :perform do
    if valid?
      source.transfer(amount.to_i,
             failure: ->(attribute, message) { errors.add(attribute, message) })
    end
    errors.messages.any? ? (display_error :new)
                         : (go_to new_improved_transfers_path)
  end

  private

  def set_context_params(params)
    return unless params

    @amount = params[:amount]
    @source_id = params[:source_id]
    @destination_id = params[:destination_id]
  end

  def find_account(id)
    Account.find_by(id: id)
  end

  Source = ImprovedMoneyTransfering::Source
  Destination = ImprovedMoneyTransfering::Destination
end
