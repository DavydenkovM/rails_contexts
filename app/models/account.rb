class Account < ActiveRecord::Base
  include Awareness

  belongs_to :user

  validates :balance, presence: true,
                      numericality: { only_integer: true, greater_than: 10 }

  scope :owned_by_others, ->(user_id) { where.not(user_id: user_id) }

  def to_s
    "Account ##{id}"
  end
end
