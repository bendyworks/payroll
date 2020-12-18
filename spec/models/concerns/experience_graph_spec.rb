# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExperienceGraph do
  describe '#to_table' do
    context 'an empty set of employees' do
      it 'returns an empty table of data' do
        employees = []

        table = ExperienceGraph.new(employees).to_table

        expect(table).to eq []
      end
    end

    context 'with multiple employees' do
      it 'returns a properly formatted set of data' do
        employee = object_double(
          build(:employee),
           weighted_years_experience: 7.967123287671233,
           current_or_last_pay: 0.1e4,
           display_name: "Mickey Mouse",
           all_experience_formatted: "Here: 7 years, 11 months\nPrior: 8 years 2 months direct, 1 years 4 months indirect",
           display_pay: "$140K"
          )

        table = ExperienceGraph.new([employee]).to_table

        expect(table.first).to match_array([
          7.967123287671233, 0.1e4,
           "Mickey Mouse:\nHere: 7 years, 11 months\nPrior: 8 years 2 months direct, 1 years 4 months indirect\n$140K salary"
        ])
      end
    end
  end
end
