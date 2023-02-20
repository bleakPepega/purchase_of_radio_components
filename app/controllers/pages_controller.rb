class PagesController < ApplicationController
  require 'nokogiri'
  require 'roo'

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

    # @gold_price = result["rates"]["XAU"]
    # @silver_price = result["rates"]["XAG"]
    # @platinum = result["rates"]["XPT"]
    # @palladium = result["rates"]["XPD"]
    @gold_price
    @silver_price
    @platinum
    @palladium
    p @gold_price
    p @silver_price
    p @platinum
    p @palladium
    # image = File.read('/home/sad/RubymineProjects/untitled4/app/assets/images/image1.jpg')
    # import
    # binding.irb
  end

end
def import
  #
  # require 'roo'
  #
  # workbook = Roo::Spreadsheet.open '/home/sad/RubymineProjects/untitled4/app/controllers/spravochnik.xlsx'
  # worksheets = workbook.sheets
  # puts "Found #{worksheets.count} worksheets"
  #
  # worksheets.each do |worksheet|
  #   puts "Reading: #{worksheet}"
  #   num_rows = 0
  #   workbook.sheet(worksheet).each_row_streaming do |row|
  #     row_cells = row.map { |cell| cell.value }
  #     num_rows += 1
  #     p row_cells
  #     product = Product.create!(
  #       group:row_cells[1],
  #       subgroup: row_cells[2],
  #       name: row_cells[3],
  #       gold: row_cells[4],
  #       silver: row_cells[5],
  #       platinum: row_cells[6],
  #       mpg: row_cells[6]
  #     )
  #   end
  #   redirect_to products_path, notice: 'Products imported successfully.'
  #   puts "Read #{num_rows} rows"
  # end

end