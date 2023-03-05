class CurrentDates < ApplicationRecord
  validates :date, presence: true

  def self.get_last_date
    CurrentDates.pluck(:date).last
  end
end
