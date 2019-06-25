class CreateBalanceTracker < ActiveRecord::Migration[5.2]
  def change
    create_table :balance_trackers do |t|
      t.integer :from_id
      t.integer :to_id
      t.float :amount

      t.timestamps
    end
  end
end
