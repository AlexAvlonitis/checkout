# frozen_string_literal: true

require_relative './base_discount_rule'

class LavenderDiscountRule < BaseDiscountRule
  ITEM_CODE            = "001"
  DISCOUNT             = 0.75
  ITEM_COUNT_THRESHOLD = 2

  def apply(items)
    super do
      lavenders = filtered_items(items)
      return if lavenders.count < ITEM_COUNT_THRESHOLD

      lavenders.each { |item| item.price -= DISCOUNT }
    end
  end

  private

  def filtered_items(items)
    items.select { |item| item.code == ITEM_CODE }
  end
end
