# frozen_string_literal: true

class ComponentsController < ApplicationController
  def index
    @currencies = PriceCalculator.currencies
    @metal_prices = PriceCalculator.metals
    @component_name = params.permit(:component)[:component]
    components_groups
    total_cost
  end

  def autocomplete_name
    @components = Component.search(component_name).limit(15)
    render :search, layout: false
  end

  def calculate
    redirect_to action: :index, sum: PriceCalculator.new(calculate_params[:component_id].to_i,
                                                         calculate_params[:quantity],
                                                         cash: cash_param).calculate, component: calculate_params[:component]
  end

  private

  def components_groups
    @components_groups ||= Component.select(:group).distinct.pluck(:group)
  end

  def component_name
    @component_name ||= params.permit(:component_name)['component_name']
  end

  def calculate_params
    @calculate_params ||= params.permit(:component_id, :component, :quantity)
  end

  def cash_param
    @cash_param ||= ActiveModel::Type::Boolean.new.cast(params.permit(:cash))
  end

  def total_cost
    @total_cost ||= params.permit(:sum)[:sum]
  end
end
