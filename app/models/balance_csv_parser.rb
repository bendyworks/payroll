class BalanceCsvParser
  def self.record(uploaded_io)
    csv = uploaded_io.read
    csv.sub! /^Date,/, 'Account,'
    account_hashes = SmarterCSV.process(StringIO.new(csv))
    record_accounts account_hashes
  end

  def self.record_accounts(account_hashes)
    account_hashes.each do |account_hash|
      record_account account_hash
    end
  end

  def self.record_account(account_hash)
    name = account_hash.delete(:account) || raise('Missing account name')
    account = Account.find_by_name(name) || raise("No account for '#{name}'")

    account_hash.each do |date_sym, balance_string|
      begin
        date = Date.strptime(date_sym.to_s, '%m/%d/%Y')
      rescue ArgumentError => e
        raise ArgumentError.new("Invalid Date: #{date_sym}")
      end
      if balance_string.is_a?(String)
        amount = balance_string.gsub(/[,$]/, '').to_d || raise('Missing amount')
      else
        amount = balance_string
      end
      balance = Balance.find_or_initialize_by(account_id: account.id, date: date)
      balance.update_attributes! amount: amount
    end
  end
end
