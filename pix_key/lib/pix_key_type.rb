# frozen_string_literal: true

require 'uri'

class PixKey
  CPF = 'cpf'
  CPF_REGEXP = /^[0-9]{11}$/

  CNPJ = 'cnpj'
  CNPJ_REGEXP = /^[0-9]{14}$/

  PHONE = 'phone'
  PHONE_REGEXP = /^\+[1-9][0-9]\d{1,14}$/

  EVP = 'evp'
  EVP_REGEXP = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

  EMAIL = 'email'
  EMAIL_REGEX = ::URI::MailTo::EMAIL_REGEXP

  module Type
    Detection =->(value) do
      return '' if value == ''

      return CPF if CPF_REGEXP.match?(value)
      return CNPJ if CNPJ_REGEXP.match?(value)
      return PHONE if PHONE_REGEXP.match?(value)
      return EVP if EVP_REGEXP.match?(value)
      return EMAIL if EMAIL_REGEXP.match?(value)

      ''
    end
  end
end
