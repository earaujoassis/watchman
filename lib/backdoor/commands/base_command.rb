# frozen_string_literal: true

class Backdoor::Commands::BaseCommand
  def initialize(params:)
    @params = params
    @valid = nil
    @errors = Hash.new
  end

  def valid?
    return false if @valid.nil?
    @valid
  end

  private

  def validator(rule, attr, message)
    @valid = rule if @valid.nil?
    @errors[attr] = message unless rule
    @valid = rule && @valid
  end
end
