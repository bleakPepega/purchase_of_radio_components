# frozen_string_literal: true

require 'net/http'

class PriceCalculator
  CURRENCIES = %w[USD EUR].freeze
  MAGIC_CONST = 28.3495

  attr_reader :component_id, :quantity, :cash
  def initialize(name, quantity, cash)
    id = Component.where(name: name).first.id
    @component_id = id
    @cash = cash
    @quantity = quantity
  end

  def calculate
    metal_prices = PriceCalculator.metals
    currencies = PriceCalculator.currencies
    component = Component.find(component_id).attributes.slice('gold', 'silver',
                                                              'platinum', 'mpg').transform_values { _1 / MAGIC_CONST }
    price = [component['gold'] * metal_prices['gold'].to_f,
             component['silver'] * metal_prices['silver'].to_f,
             component['platinum'] * metal_prices['platinum'].to_f,
             component['mpg'] * metal_prices['palladium'].to_f].reduce(&:+) * quantity.to_i * currencies[:USD].to_f
    # if @cash != "true"
    #    price
    # else
    #   price * 0.94
    # end
    price
  end

  class << self
    def metals
      url = URI.parse(Rails.configuration.exchanges_ranges.metals_url)
      begin
      Rails.cache.fetch('metals', expires_in: 1.hours) do
        JSON.parse(Net::HTTP.get_response(url).body).reduce(:merge)
      rescue JSON::ParserError
        metals
        end
      end
    end

    def currencies
      url = URI.parse(Rails.configuration.exchanges_ranges.currency_url)
      res = Hash.from_xml(Net::HTTP.get_response(url).body).dig('ValCurs', 'Valute')

      res.select { CURRENCIES.include?(_1['CharCode']) }.map { { "#{_1['CharCode']}": _1['Value'].sub(',', '.').to_f } }.reduce(:merge)
    end
  end
end
