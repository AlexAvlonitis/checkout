# frozen_string_literal: true
require 'pry'

class Basket
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @items = []
  end

  def add(item)
    raise ArgumentError unless item

    items << item
  end

  def checkout
    promotional_rules.each { |rule| rule.apply(items) }

    total_price.round(2)
  end

  private

  attr_reader :promotional_rules, :items

  def total_price
    items.inject(0) { |sum, item| sum + item.price }
  end
end
