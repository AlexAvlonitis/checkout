# frozen_string_literal: true

require_relative './base_discount_rule'

class OverallDiscountRule < BaseDiscountRule
  DISCOUNT_PERCENTAGE = 10
  THRESHOLD_VALUE     = 60

  def apply(items)
    super do
      return if items_total_cost(items) <= THRESHOLD_VALUE

      items.each do |item|
        item.price -= (item.price * DISCOUNT_PERCENTAGE) / 100
      end
    end
  end

  private

  def items_total_cost(items)
    items.inject(0) { |sum, item| sum + item.price }
  end
end
