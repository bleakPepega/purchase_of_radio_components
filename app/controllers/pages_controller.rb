class PagesController < ApplicationController
  require 'nokogiri'

  def index
    require 'open-uri'
    url = 'http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    valcurs = doc.at('valcurs')
    currencies = valcurs.css('valute')
    @arrayWithMoney = []
    currencies.each do |currency|
      code = currency.at('charcode').text
      name = currency.at('name').text
      value = currency.at('value').text
      if code == "USD" or code == "EUR"
        # @arrayWithMoney << name
        # @arrayWithMoney << code
        @arrayWithMoney << value
      end
    end
    require 'net/http'
    require 'json'

    url = "https://metals-api.com/api/latest?access_key=bigq7q5l1j5681nbp1vk1uv437fgae13qvdtamy68z3wse89u1kba8mwc97k&symbols=XAU,XAG,XPT,XPD"
    response = Net::HTTP.get_response(URI.parse(url))
    result = JSON.parse(response.body)

    @gold_price = result["rates"]["XAU"]
    @silver_price = result["rates"]["XAG"]
    @platinum = result["rates"]["XPT"]
    @palladium = result["rates"]["XPD"]
    p @gold_price
    p @silver_price
    p @platinum
    p @palladium
    @fields = %w[test pepega from telega]
  end
end
