class ChangeCompensationsFieldsType < ActiveRecord::Migration
  def change
      change_column :compensations, :actual_paid, :integer
      change_column :compensations, :target, :integer
      change_column :compensations, :base_salary, :integer
      change_column :compensations, :total, :integer
      change_column :compensations, :annual_equivalent, :integer
      change_column :compensations, :rate, :integer
  end
end
