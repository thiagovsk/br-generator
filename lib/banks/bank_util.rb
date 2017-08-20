require_relative '../utils/randomizer'
require_relative 'bank'
include Randomizer

# Generates the bank data with valid digits.
class BankUtil
  def initialize(bank)
    @bank = bank.code
    @agency = bank.agency
    @account = bank.account
    @account_check = bank.account_check
  end

  def generate
    result = { bank: @bank }

    result[:agency_number] = generate_number_len(@agency.digits)
    generate_agency_check_number(result)
    generate_account_number(result)
    generate_account_check_number(result)
    unless @account.default_begin.empty?
      result[:account_number] =
        @account.default_begin = result[:account_number]
    end

    result
  end

  def generate_with_data(agency, account)
    result = { bank: @bank, agency_number: agency }

    generate_agency_check_number result
    result[:account_number] = account
    generate_account_check_number result

    result
  end

  def generate_agency_check_number(result)
    return unless @agency.agency_rule?
    agency_check_number = @agency.rule.execute(result[:agency_number])
    result[:agency_check_number] = agency_check_number
  end

  def generate_account_number(result)
    result[:account_number] =
      generate_number_len_range(@account.min_digits, @account.max_digits)
  end

  def generate_account_check_number(result)
    account = trim_account(result[:account_number])

    account_number = if @account_check.include_agency?
                       result[:agency_number] + @account_check.agency_ending +
                         account
                     else
                       account
                     end

    result[:account_check_number] = @account_check.rule.execute(account_number)
  end

  def trim_account(account)
    if account.length > @account.max_digits
      diff = account.length - @account.max_digits
      account = account[diff..-1]
    end
    account
  end

  def self.validate(bank_code, agency, agency_check, account, account_check)
    result = Object.const_get(Bank.bank(bank_code).to_s).new
                   .generate_with_data(agency, account)

    BankUtil.validate_result(result, agency_check, account_check)

    result
  end

  def self.validate_result(result, agency_check, account_check)
    result['valid'] = if result.key?('agency_check_number') &&
                         result[:agency_check_number] != agency_check
                        false
                      elsif result[:account_check_number] != account_check
                        false
                      else
                        true
                      end
  end
end
