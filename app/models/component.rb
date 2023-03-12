# frozen_string_literal: true

class Component < ApplicationRecord
  scope :search, ->(name) { where('LOWER(name) LIKE ?', "%#{name.downcase}%") }
end
