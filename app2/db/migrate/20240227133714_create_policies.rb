class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.date :issue_date
      t.date :coverage_end_date
      t.timestamps
    end
  end
end
