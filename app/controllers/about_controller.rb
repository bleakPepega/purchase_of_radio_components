# frozen_string_literal: true

class AboutController < ApplicationController
  def index
    @currencies = PriceCalculator.currencies
    @metal_prices = PriceCalculator.metals
    render 'about'
  end
end
