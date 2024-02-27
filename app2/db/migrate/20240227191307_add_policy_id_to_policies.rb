class AddPolicyIdToPolicies < ActiveRecord::Migration[7.0]
  def change
    add_column :policies, :policy_id, :integer
  end
end
