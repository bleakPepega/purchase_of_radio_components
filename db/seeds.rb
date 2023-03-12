# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'roo'

CATALOG_PATH = './spravochnik.xlsx'

file = Roo::Spreadsheet.open(CATALOG_PATH)
file.sheets.each do |sheet_name|
  Rails.logger.info "Reading worksheet #{sheet_name}"
  file.sheet(sheet_name).parse(group: 'Группа', subgroup: 'Подгруппа', name: 'Наименование',
                               gold: 'Золото', silver: 'Серебро', platinum: 'Платина', mpg: 'МПГ') do |component|
    Component.create!(component)
  #   each do |component|
  #   Component.create!(group: component[:group],
  #                     subgroup: component[:subgroup],
  #                     name: component[:subgroup],
  #                     gold: component[:gold],
  #                     silver: component[:silver],
  #                     platinum: component[:platinum],
  #                     mpg: component[:mpg])
  end
  Rails.logger.info 'Components from sheet imported successfully.'
end
