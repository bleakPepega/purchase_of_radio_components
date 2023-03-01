class PagesController < ApplicationController
  require 'nokogiri'
  require 'roo'
  require 'date'
  require 'net/http'
  require 'json'
  def index
    require 'open-uri'
    url = 'http://www.cbr.ru/scripts/XML_daily.asp?date_req='
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
    q = CurrentDates.get_last_date
    if (q - Date.today) != (0/1)
      update_price
    end
  end

  def update_price
    url = "https://metals-api.com/api/latest?access_key=9a9o992r9b7d3s255g6rfpn368yzoixc2t73v6q18blu9h634an6bsi59e2r&symbols=XAU,XAG,XPT,XPD"
    response = Net::HTTP.get_response(URI.parse(url))
    result = JSON.parse(response.body)
    gold_price = result["rates"]["XAU"]
    silver_price = result["rates"]["XAG"]
    platinum = result["rates"]["XPT"]
    palladium = result["rates"]["XPD"]
    prices = MetalPrice.new(
      gold: gold_price,
      platinum: platinum,
      silver: silver_price,
      palladium: palladium
    )
    MetalPrice.delete_all
    prices.save!
    current_dates = CurrentDates.new(
      date: Date.today
    )
    CurrentDates.delete_all
    current_dates.save!
  end

end