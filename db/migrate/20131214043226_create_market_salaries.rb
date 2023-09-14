class CreateMarketSalaries < ActiveRecord::Migration
  def change
    create_table :market_salaries do |t|
      t.datetime :submitted_date
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :certified_begin_date
      t.datetime :certified_end_date
      t.datetime :dol_decision_date
      t.boolean :part_time, default: false
      t.string :case_number, default: ''
      t.string :program_designation, default: ''
      t.string :employer_name, default: ''
      t.string :employer_city, default: ''
      t.string :employer_address, default: ''
      t.string :employer_state, default: ''
      t.string :employer_postal_code, default: ''
      t.string :nbr_immigrants, default: ''
      t.string :job_title, default: ''
      t.string :occupation_code, default: ''
      t.string :approval_status, default: ''
      t.string :wage_rate_from, default: ''
      t.string :wage_rate_per, default: ''
      t.string :wage_rate_to, default: ''
      t.string :work_city, default: ''
      t.string :work_state, default: ''
      t.string :prevailing_wage, default: ''

      t.timestamps
    end
  end
end
