class User < ApplicationRecord
  devise   :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

  has_many :events,
           inverse_of: 'administrator',
           foreign_key: 'administrator_id'

  has_many :attendances
  has_many :purchased_events,
           through: :attendances,
           source: :event

  validates :email, uniqueness: true
end
