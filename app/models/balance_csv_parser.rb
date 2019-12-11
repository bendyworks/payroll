# frozen_string_literal: true

class BalanceCsvParser
  def self.record(uploaded_io)
    csv = File.read(uploaded_io, encoding: "utf-8")
    csv.sub!(/^Date,/, 'Account,')
    account_hashes = SmarterCSV.process(StringIO.new(csv))
    record_accounts account_hashes
  end

  private

  def self.record_accounts(account_hashes)
    account_hashes.each do |account_hash|
      record_account account_hash
    end
  end
  private_class_method :record_accounts

  def self.record_account(account_hash)
    name = account_hash.delete(:account) || fail('Missing account name')
    account = Account.find_by_name(name) || fail("No account for '#{name}'")

    account_hash.each do |date_sym, balance_string|
      record_account_entry account, date_sym, balance_string
    end
  end
  private_class_method :record_account

  def self.record_account_entry(account, date_sym, balance_string)
    date = parse_date(date_sym)
    amount = parse_amount(balance_string)
    balance = Balance.find_or_initialize_by(account_id: account.id, date: date)
    balance.update! amount: amount
  end
  private_class_method :record_account_entry

  def self.parse_date(date_sym)
    Date.strptime(date_sym.to_s, '%m/%d/%Y')
  rescue ArgumentError
    raise ArgumentError, "Invalid Date: #{date_sym}"
  end
  private_class_method :parse_date

  def self.parse_amount(balance_string)
    if balance_string.is_a?(String)
      balance_string.gsub(/[,$]/, '').to_d || fail('Missing amount')
    else
      balance_string
    end
  end
  private_class_method :parse_amount
end
