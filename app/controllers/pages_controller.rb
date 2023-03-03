class PagesController < ApplicationController
  require 'nokogiri'
  require 'roo'
  require 'date'
  require 'net/http'
  require 'json'
  require 'open-uri'
  def index
    @group_value
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
    input_value = params[:value]['name']
    quantityValue = params[:value]['quantity'].to_i
    p input_value
    p quantityValue
    gold = Product.where(name: input_value).pluck(:gold)
    silver = Product.where(name: input_value).pluck(:silver)
    platinum = Product.where(name: input_value).pluck(:platinum)
    mpg = Product.where(name: input_value).pluck(:mpg)
    p gold
    finaly_cost = gold[0] * MetalPrice.pluck(:gold)[0] + silver[0] * MetalPrice.pluck(:silver)[0]  + platinum[0] * MetalPrice.pluck(:platinum)[0] + mpg[0] * MetalPrice.pluck(:palladium)[0]
    finaly_cost *= quantityValue
    if params[:value]['year'] == "card"
      finaly_cost *= 0.94
    end
    finaly_cost = finaly_cost.ceil(2)
    render json: finaly_cost


  end



  end