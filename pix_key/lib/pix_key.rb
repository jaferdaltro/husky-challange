# frozen_string_literal: true

require 'pry'
require  'active_model'
# require 'u-case'
require 'u-case/with_activemodel_validation'


Micro::Case.config do |config|
  config.enable_activemodel_validation = true
end

module PixTypes
  REG_EMAIL	= /\A[\w.+-]+@\w+\.\w+\z/
  REG_CPF	= /\A[0-9]{11}\z/
  REG_CNPJ = /\A[0-9]{14}\z/
  REG_PHONE =	/\A\+[1-9][0-9]\d{1,14}\z/
  REG_EVP = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
end

class PixKey
  include ActiveModel::Validations
  attr_reader :type, :value
  alias :key :value

  validates :key, format: { with: PixTypes::REG_EMAIL }

  def initialize(value)
    @value = String(value).strip.freeze
    @type = choose_type
  end

  private


  def choose_type
    return 'email' unless @value !~ PixTypes::REG_EMAIL
    return 'cpf' unless @value !~ PixTypes::REG_CPF
    return 'cnpj' unless @value !~ PixTypes::REG_CNPJ
    return 'phone' unless @value !~ PixTypes::REG_PHONE
    return 'evp' unless @value !~ PixTypes::REG_EVP
  end
end

