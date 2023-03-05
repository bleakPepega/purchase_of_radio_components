class PagesController < ApplicationController
  require 'nokogiri'
  require 'roo'
  require 'date'
  require 'net/http'
  require 'json'
  require 'open-uri'
  def index
    array_with_money
    current_dates = CurrentDates.get_last_date
    if (current_dates - Date.today) != (0/1)
      update_price
    end
    dropping_list
  end

  def update_price
    url = "https://metals-api.com/api/latest?access_key=9a9o992r9b7d3s255g6rfpn368yzoixc2t73v6q18blu9h634an6bsi59e2r&symbols=XAU,XAG,XPT,XPD"
    response = Net::HTTP.get_response(URI.parse(url))
    result = JSON.parse(response.body)
    gold_price = 1 / result["rates"]["XAU"]
    silver_price = 1 / result["rates"]["XAG"]
    platinum = 1 / result["rates"]["XPT"]
    palladium = 1 / result["rates"]["XPD"]
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
  def dropping_list
    @group = Product.pluck(:group).uniq

  end
  def autocomplete_data
    autocomplete_data = Product.pluck(:group).uniq
    render json: autocomplete_data
  end
  
  def process_group_value
    group_value = params[:group]
    a = Product.where(group: group_value).pluck(:name).uniq
    render json: a
  end

  def process_input_value
    finally_cost = formula_for_calculation
    render json: finally_cost
  end

  private

  def array_with_money
    url = 'http://www.cbr.ru/scripts/XML_daily.asp?date_req='
    response = Net::HTTP.get_response(URI.parse(url))
    xml = Hash.from_xml(response.body)
    currencies = xml['ValCurs']['Valute']
    @arrayWithMoney = currencies.select do |currency|
      code = currency['CharCode']
      code == "USD" || code == "EUR"
    end.map do |currency|
      currency['Value'].gsub(',', '.').to_f.round(2)
    end
  end
  def formula_for_calculation
    input_value = params[:value]['name']
    quantity_value = params[:value]['quantity'].to_i
    usd = array_with_money
    gold, silver, platinum, mpg = Product.where(name: input_value).pluck(:gold, :silver, :platinum, :mpg).flatten
    finally_cost = (gold / 28.3495 * MetalPrice.pluck(:gold)[0] + silver / 28.3495 * MetalPrice.pluck(:silver)[0]  + platinum / 28.3495 * MetalPrice.pluck(:platinum)[0] + mpg / 28.3495 * MetalPrice.pluck(:palladium)[0]) * quantity_value * usd[0].to_f
    finally_cost *= 0.94 if params[:value]['year'] == "card"
    finally_cost.ceil(2)
  end

end