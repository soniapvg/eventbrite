class Event < ApplicationRecord
  belongs_to :user

  has_many :attendances
  has_many :participants, through: :attendances, source: :user

  validates :start_date, :duration, :title, :description, :price, :location, presence: true

  validates :start_date, comparison: { greater_than: Time.now }
  validates :title, length: { in: 5..140 }
  validates :description, length: { in: 20..1000 }
  validates :price, numericality: { in: 1..1000 }
  validates :duration, comparison: { greater_than: 0 }

  validate  :duration_must_be_multiple_of_five

  private

  def duration_must_be_multiple_of_five
    return if (duration % 5).zero?

    errors.add(:duration, 'must be a multiple of 5')
  end
end
