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

    generate_numbers(result)

    result
  end

  def generate_numbers(result)
    agency_number = generate_agency_number
    result[:agency_number] = agency_number
    if @agency.agency_rule?
      result[:agency_check_number] = generate_agency_check_number(agency_number)
    end
    account_number = generate_account_number
    result[:account_number] = account_number
    account_check_number = generate_account_check_number(account_number)
    result[:account_check_number] = account_check_number
  end

  def generate_with_data(agency, account)
    result = { bank: @bank, agency_number: agency }

    result[:agency_check_number] = generate_agency_check_number(agency)
    result[:account_number] = account
    result[:account_check_number] = generate_account_check_number(account)

    result
  end

  def generate_agency_number
    generate_number_len(@agency.digits)
  end

  def generate_agency_check_number(agency_number)
    return unless @agency.agency_rule?
    @agency.rule.execute(agency_number)
  end

  def generate_account_number
    account_number =
      generate_number_len_range(@account.min_digits, @account.max_digits)
    return @account.default_begin + account_number unless @account
                                                          .default_begin.empty?
    account_number
  end

  def generate_account_check_number(account, agency_number = '')
    account = trim_account(account)

    account_number = if @account_check.include_agency?
                       agency_number + @account_check.agency_ending +
                         account
                     else
                       account
                     end

    @account_check.rule.execute(account_number)
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
