class ProductsController < ApplicationController
  def autocomplete_data
    autocomplete_data = Product.pluck(:subgroup).uniq
    render json: autocomplete_data
  end
end
