# frozen_string_literal: true

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
  end

  def scan(item)
    basket.add(item)
  end

  def total
    basket.checkout
  end

  private

  attr_reader :promotional_rules

  def basket
    @basket ||= Basket.new(promotional_rules)
  end
end
