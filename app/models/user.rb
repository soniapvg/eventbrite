class User < ApplicationRecord
  has_many :events, class_name: 'Event'

  has_many :attendances
  has_many :purchased_events, through: :attendances, source: :event

  validates :email, uniqueness: true
end
