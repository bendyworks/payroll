require 'spec_helper'

describe SalaryChart do
  context 'creating chart with current salaries' do
    context 'when no chart options are specified' do
      salary_chart = SalaryChart.new(employment: { current: 1 })
      it 'should have a large chart' do
        expect(salary_chart.chart.options['width']).to eql(800)
        expect(salary_chart.chart.options['height']).to eql(500)
      end
    end
    context 'when chart options are specified' do
      chart_options = { height: 300, width: 300 }
      salary_chart = SalaryChart.new({ employement: { current: 1 } }, chart_options)
      it 'should have a chart with dimentions that match' do
        expect(salary_chart.chart.options['width']).to eql(chart_options[:width])
        expect(salary_chart.chart.options['height']).to eql(chart_options[:height])
      end
    end
  end
end
