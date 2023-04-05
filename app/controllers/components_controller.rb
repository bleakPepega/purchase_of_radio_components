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
  def autocomplete_name1
    search_term = params[:q]
    p search_term
    array = []
    components = Component.search(search_term).limit(15)
    components.each do |component|
      array << component.name
    end
    render json: array
  end
  def get_group
    name = params[:name]
    group = Component.where(name: name).first.group
    render json: { value: group }
  end
  def test
    param = request.params
    cash = params[:"cash-0"]
    summ = 0.0
    array = []
    param.each do |key, value|
      array << value
    end
    array.pop(2)
    array.each_slice(3){|slice| summ += (PriceCalculator.new( slice[1], slice[0], slice[2]).calculate)}
    if cash == "false"
      summ *= 0.94
    end
    render json: summ.round(2)
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
