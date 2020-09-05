# frozen_string_literal: true

require 'spec_helper'
require 'checkout'

describe Checkout do
  let(:subject) { described_class.new(promotional_rules) }
  let(:promotional_rules) { [] }

  let(:item1) { double(:item1, code: '002', name: 'Personalised cufflinks', price: 10) }

  describe '#scan' do
    it 'sends the #add message to basket with an item parameter' do
      expect_any_instance_of(Basket).to receive(:add).with(item1)
      subject.scan(item1)
    end
  end

  describe '#total' do
    it 'sends the #checkout message to basket' do
      expect_any_instance_of(Basket).to receive(:checkout)
      subject.total
    end
  end
end
