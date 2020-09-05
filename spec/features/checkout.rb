# frozen_string_literal: true

require 'spec_helper'
require 'checkout'
require 'basket'
require 'rules/rules_container'
require 'rules/lavender_discount_rule'
require 'rules/overall_discount_rule'

describe Checkout do
  let(:subject) { described_class.new(promotional_rules) }
  let(:promotional_rules) do
    RulesContainer.new(LavenderDiscountRule.new, OverallDiscountRule.new)
  end

  describe 'fullfil: Basket: 001,002,003 - Total price expected: £66.78' do
    item1  = OpenStruct.new(code: '001', name: 'Lavender heart', price: 9.25)
    item2  = OpenStruct.new(code: '002', name: 'Personalised cufflinks', price: 45.00)
    item3  = OpenStruct.new(code: '003', name: 'Kids T-shirt', price: 19.95)

    it 'returns correct results' do
      [item1, item2, item3].each { |item| subject.scan(item) }

      expect(subject.total).to eq 66.78
    end
  end

  describe 'fullfil: Basket: 001,003,001 - Total price expected: £36.95' do
    item1  = OpenStruct.new(code: '001', name: 'Lavender heart', price: 9.25)
    item1b = OpenStruct.new(code: '001', name: 'Lavender heart', price: 9.25)
    item3  = OpenStruct.new(code: '003', name: 'Kids T-shirt', price: 19.95)

    it 'returns correct results' do
      [item1, item3, item1b].each { |item| subject.scan(item) }

      expect(subject.total).to eq 36.95
    end
  end

  describe 'fullfil: Basket: 001,002,001,003 - Total price expected: £73.76' do
    item1  = OpenStruct.new(code: '001', name: 'Lavender heart', price: 9.25)
    item1b = OpenStruct.new(code: '001', name: 'Lavender heart', price: 9.25)
    item2  = OpenStruct.new(code: '002', name: 'Personalised cufflinks', price: 45.00)
    item3  = OpenStruct.new(code: '003', name: 'Kids T-shirt', price: 19.95)

    it 'returns correct results' do
      [item1, item2, item1b, item3].each { |item| subject.scan(item) }

      expect(subject.total).to eq 73.76
    end
  end
end
