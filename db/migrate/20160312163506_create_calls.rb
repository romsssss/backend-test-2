class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :uuid, null: false, index: true
      t.string :caller_id
      t.string :caller_name
      t.belongs_to :company_number, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :answer_time
      t.integer :duration
      t.string :status
      t.string :hangup_cause
    end
  end
end
