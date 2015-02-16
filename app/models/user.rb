class User < ActiveRecord::Base
  include Awareness

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts, dependent: :destroy
end
