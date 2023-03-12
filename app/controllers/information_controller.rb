class InformationController < ApplicationController
  def index
    @currencies = PriceCalculator.currencies
    @metal_prices = PriceCalculator.metals
  end
end
