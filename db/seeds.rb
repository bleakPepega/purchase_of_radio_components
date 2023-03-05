# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'roo'

workbook = Roo::Spreadsheet.open '/home/sad/RubymineProjects/untitled4/app/controllers/spravochnik.xlsx'
worksheets = workbook.sheets
puts "Found #{worksheets.count} worksheets"

worksheets.each do |worksheet|
  puts "Reading: #{worksheet}"
  num_rows = 0
  workbook.sheet(worksheet).each_row_streaming do |row|
    row_cells = row.map { |cell| cell.value }
    num_rows += 1
    p row_cells
    product = Product.create!(
      group:row_cells[1],
      subgroup: row_cells[2],
      name: row_cells[3],
      gold: row_cells[4],
      silver: row_cells[5],
      platinum: row_cells[6],
      mpg: row_cells[7]
    )
  end
  redirect_to products_path, notice: 'Products imported successfully.'
  puts "Read #{num_rows} rows"
end