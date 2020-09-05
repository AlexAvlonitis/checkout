# frozen_string_literal: true

class BaseDiscountRule
  def initialize
    @applied = false
  end

  def apply(items)
    return if @applied

    yield if block_given?

    @applied = true
  end
end
