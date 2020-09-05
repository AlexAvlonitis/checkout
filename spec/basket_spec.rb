# frozen_string_literal: true

require 'spec_helper'
require 'basket'
require 'rules/rules_container'
require 'rules/lavender_discount_rule'
require 'rules/overall_discount_rule'

describe Basket do
  let(:subject) { described_class.new(promotional_rules) }
  let(:promotional_rules) { [rule1, rule2] }

  let(:rule1) { double(:rule1) }
  let(:rule2) { double(:rule2) }

  let(:item1) { double(:item1, code: '002', name: 'Personalised cufflinks', price: 10) }
  let(:item2) { double(:item2, code: '001', name: 'Lavender heart', price: 9.50) }
  let(:item3) { double(:item3, code: '003', name: 'Kids T-shirt', price: 19.95) }

  before do
    allow(rule1).to receive(:apply)
    allow(rule2).to receive(:apply)
  end

  describe '#add' do
    context 'When we add items' do
      it 'adds them successfuly' do
        subject.add(item1)
        expect(subject.add(item2)).to eq [item1, item2]
      end
    end

    context 'When we add an empty item' do
      it 'raises argument error' do
        expect { subject.add }.to raise_error ArgumentError
      end
    end
  end

  describe '#checkout' do
    before { 2.times { subject.add(item1) } }

    context 'When there are rules' do
      it 'applies all the rules to all items' do
        expect(rule1).to receive(:apply).with([item1, item1])
        expect(rule2).to receive(:apply).with([item1, item1])

        subject.checkout
      end
    end

    context 'When there are no rules' do
      let(:promotional_rules) { [] }

      it 'does not apply any rules' do
        expect(rule1).not_to receive(:apply).with([item1, item1])
        subject.checkout
      end
    end
  end
end
