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
          id: 333,
          weighted_years_experience: 7.967123287671233,
          current_or_last_pay: 0.1e4,
          display_name: 'Mickey Mouse',
          all_experience_formatted: "Here: 7 years, 11 months\nPrior: 8 years 2 months direct, 1 years 4 months indirect",
          display_pay: '$140K'
        )

        table = ExperienceGraph.new([employee]).to_table

        expect(table).to match_array([
                                       { id: employee.id,
                                         name: employee.display_name,
                                         experience: employee.weighted_years_experience,
                                         salary: employee.current_or_last_pay }
                                     ])
      end
    end
  end
end
