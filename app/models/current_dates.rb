class CurrentDates < ApplicationRecord
  validates :date, presence: true

  def self.get_last_date
    order(date: :desc).first&.date
  end
end
