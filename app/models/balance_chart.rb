# frozen_string_literal: true

class BalanceChart
  attr_reader :chart

  def initialize
    opts = { width: 800, height: 500, legend: 'right',
             vAxis: { minValue: 0, gridlines: { count: 10 } } }

    @accounts = Account.all

    @chart = GoogleVisualr::Interactive::LineChart.new(chart_data, opts)
  end

  def to_table
    Balance.ordered_dates.map do |date|
      table_row_for(date)
    end
  end

  private

  def format_date(date)
    date.to_time.to_f * 1000
  end

  def table_row_for(date)
    row = { date: format_date(date) }

    @accounts.each do |account|
      row[account.id] = { name: account.name, balance: account.balances.find_by(date: date) }
    end

    row
  end

  def chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')

    create_account_columns! data_table
    populate_history_chart_data! data_table
    data_table
  end

  def create_account_columns!(data_table)
    @accounts.each do |account|
      data_table.new_column('number', account.name)
    end
  end

  def populate_history_chart_data!(data_table)
    populate_balances! data_table
  end

  def populate_balances!(data_table)
    data_table.add_rows(balance_dates.count)

    balance_dates.each_with_index do |date, date_row_num|
      data_table.set_cell(date_row_num, 0, date)

      @accounts.each_with_index do |account, account_column_num|
        data_table.set_cell(date_row_num, account_column_num + 1, account.balance_on(date))
      end
    end
  end

  def balance_dates
    @balance_dates ||= Balance.ordered_dates
  end
end
