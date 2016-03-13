class AddUserNumberToCall < ActiveRecord::Migration
  def change
    add_column :calls, :user_number_id, :integer
    add_index :calls, :user_number_id
  end
end
