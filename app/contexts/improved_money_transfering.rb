class ImprovedMoneyTransfering
  include ActiveModel::Model
  extend Surrounded::Context

  attr_reader :source, :destination, :controller
  attr_accessor :amount, :destination_id, :source_id

  def initialize(controller, source = nil, destination = nil, params = nil)
    map_roles([[:source, source],
               [:destination, destination],
               [:controller, controller]])
    set_params(params)
    super()
  end

  delegate :display_error,
           :go_to,
           :new_improved_transfers_path, to: :controller

  validates :amount, presence: true,
                     numericality: { only_integer: true, greater_than: 10 }

  trigger :perform do
    if valid?
      source.transfer(amount.to_i,
             failure: ->(attribute, message) { errors.add(attribute, message) })
    end
    errors.messages.any? ? (display_error :new) : (go_to new_improved_transfers_path)
  end

  private

  def set_params(params)
    return unless params

    self.amount = params[:amount]
    self.source_id = params[:source_id]
    self.destination_id = params[:destination_id]
  end

  Source = ImprovedMoneyTransfering::Source
  Destination = ImprovedMoneyTransfering::Destination
end
