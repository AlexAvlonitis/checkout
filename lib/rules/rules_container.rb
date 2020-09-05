# frozen_string_literal: true

require 'forwardable'

class RulesContainer
  include Enumerable
  extend Forwardable
  def_delegators :@rules, :each

  def initialize(*rules)
    @rules = rules
  end
end
