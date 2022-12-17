require_relative 'pix_key_type'

class PixKey
  attr_reader :value, :type, :valid

  def initialize(arg)
    @value = arg.is_a?(::String) ? arg.strip.freeze : ''
    @type = Type::Detection[@value]
    @valid = @type != ''
  end

  alias valid? valid
  def invalid? = !valid

  def evp? = type == EVP
  def cpf? = type == CPF
  def cnpj? = type == CNPJ
  def phone? = type == PHONE
  def email? = type == EMAIL

  def ==(other)
    other.class == self.class && other.value == value
  end

  alias key value
  alias to_s value

end
