# frozen_string_literal: true

task rails_best_practices: :environment do
  sh 'rails_best_practices'
end

task default: :rails_best_practices
