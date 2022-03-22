require 'rails_helper'

describe Employee do
  it { should have_many :tenures }
  it { should have_many :salaries }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :starting_salary }

  describe "Create an employee" do
    let(:employee) { build :employee }

    it "that saves correctly" do
      expect(employee.save).to eq(true)
    end

    describe "that doesn't save" do
      it "because of no direct experience" do
        employee.direct_experience = nil
        expect { employee.save! }.to raise_error(ActiveRecord::NotNullViolation, /null value/)
      end

      it "because of no indirect experience" do
        employee.indirect_experience = nil
        expect { employee.save! }.to raise_error(ActiveRecord::NotNullViolation, /null value/)
      end

      it "because of no starting salary" do
        employee.starting_salary = nil
        expect { employee.save! }.to raise_error(ActiveRecord::RecordInvalid, /Starting salary can't be blank/)
      end
    end

    describe "with a current tenure" do
      let(:employee) { create :employee }
      let(:tenure) { create :tenure, employee: employee, start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }

      describe "and a single salary" do
        let(:salary) { build :salary, employee: employee, start_date: tenure.start_date }

        it "and saves correctly" do
          expect(salary.save).to eq(true)
        end
      end

      describe "and multiple salaries" do
        let(:salary_list) { build_list :salary, 2, employee: employee }

        it "and saves correctly" do
          salary_list.each_with_index do |salary, index|
            salary.start_date = tenure.start_date + index
            expect(salary.save!).to eq(true)
          end
        end
      end
    end
  end

  describe "Testing scopes" do
    it "default scope of ordering by first name is working" do
      default_scope_employee = Employee.first
      sorted_employee = Employee.order("first_name").first
      expect(default_scope_employee.id).to eq(sorted_employee.id)
    end

    it "past scope finds past employees" do
      past_scope_employee = Employee.past.first
      expect(past_scope_employee.first_name).to eq('Darkwing (gone)')
    end

    it "future scope finds future employees" do
      future_scope_employee = Employee.future.first
      expect(future_scope_employee.first_name).to eq('Daffy (future)')
    end

    it "non current scope finds employees not in the current scope" do
      current_scope_employees = Employee.current.pluck(:id)
      non_current_scope_employees = Employee.non_current.pluck(:id)
      expect(current_scope_employees & non_current_scope_employees).to eq([])
    end

    it "billed scope finds employees not in the support scope" do
      support_scope_employees = Employee.support.pluck(:id)
      billed_scope_employees = Employee.billed.pluck(:id)
      expect(support_scope_employees & billed_scope_employees).to eq([])
    end
  end

  describe "Testing model methods" do
    let(:employee) { Employee.find_by(first_name: "Goofy") }
    it "check to see if start_date outputs the start date for the first tenure" do
      expect(employee.start_date).to eq(employee.tenures.order("start_date ASC").first.start_date)
    end

    it "check to see if end_date outputs the end date for the first tenure" do
      expect(employee.end_date).to eq(employee.tenures.order("end_date ASC").last.end_date)
    end

    describe "check to see if an employee was employed on the test date" do
      it "and that should return false" do
        date_to_check = Faker::Date.between(from: Date.parse('2012-12-30'), to: Date.parse('2013-10-27'))
        expect(employee.employed_on?(date_to_check)).to eq(false)
      end

      it "and that should return true" do
        date_to_check = Faker::Date.between(from: Date.parse('2013-10-30'), to: Date.parse('2013-12-31'))
        expect(employee.employed_on?(date_to_check)).to eq(true)
      end
    end

    it "check if display_name outputs first and last name" do
      expect(employee.display_name).to eq("#{employee.first_name} #{employee.last_name}")
    end

    it "check to see if an employee had a salary on the test date" do
      date_to_check = Faker::Date.between(from: Date.parse('2013-10-30'), to: Date.parse('2013-12-31'))
      expect(employee.salary_on(date_to_check).to_s).to eq("100000.0")
    end

    it "check to see an employee's ending salary was on the test date" do
      employee = Employee.find_by(first_name: "Darkwing (gone)")
      expect(employee.ending_salary.to_s).to eq("200000.0")
    end

    it "check an employee's weighted experience" do
      expect(employee.weighted_years_experience).to be_a(Numeric)
    end

    it "check an employee's weighted experience" do
      expect(employee.experience_here_formatted).to match(/\d* years, \d+ months/)
    end

    it "check an employee's current or last salary" do
      expect(employee.current_or_last_pay.to_s).to eq("100000.0")
    end

    it "check an employee's current salary, but formatted" do
      expect(employee.display_pay.to_s).to eq("$100K")
    end

    it "check an employee's previous salary, but formatted" do
      expect(employee.display_previous_pay.to_s).to eq("$55K")
    end

    it "check an employee's last raise date" do
      expect(employee.last_raise_date.to_s).to eq("2013-10-28")
    end

    it "check an employee's planned raise date" do
      date_to_use = Faker::Date.between(from: 2.days.ago, to: Date.today)
      employee.planning_raise_date = date_to_use
      employee.save
      expect(employee.bip_planning_raise_date.to_s).to eq(date_to_use.try(:strftime, '%m/%d/%Y'))
    end
  end
end